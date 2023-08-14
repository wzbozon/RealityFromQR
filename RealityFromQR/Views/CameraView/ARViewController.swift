//
//  ARViewController.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 25/06/2023.
//

import ARKit
import Combine
import RealityKit
import UIKit

class ARViewController: UIViewController {
    init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLayout()
        setupARView()

        didSetupView = true
    }

    lazy var arView: ARView = {
        let view = ARView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private var disposeBag = Set<AnyCancellable>()
    private let model = Model.shared
    private let userDefaults: UserDefaults
    private(set) var didSetupView = false
}

// MARK: - ARSessionDelegate

extension ARViewController: ARSessionDelegate {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        // TODO: https://gist.github.com/CassiusPacheco/bf3fdc9e27b189d9b2c858caa65a3b67
        if let value = userDefaults.value(forKey: UDKey.isUsingQRCode) as? Bool, value == true {
            guard
                let imageAnchor = anchors[0] as? ARImageAnchor,
                let imageName = imageAnchor.name,
                imageName == AppConstants.qrCodeImageName
            else {
                return
            }

            // AnchorEntity(world: imageAnchor.transform) results in anchoring
            // virtual content to the real world.  Content anchored like this
            // will remain in position even if the reference image moves.
            let originalImageAnchor = AnchorEntity(world: imageAnchor.transform)
            arView.scene.addAnchor(originalImageAnchor)

            if let entity = model.entity {
                setupEntity(entity, originalImageAnchor)
            } else {
                loadEntityAsync(name: AppConstants.defaultModelFileName, anchor: originalImageAnchor)
            }
        } else {
            guard let planeAnchor = anchors[0] as? ARPlaneAnchor else { return }
            let anchor = AnchorEntity(world: planeAnchor.transform)
            arView.scene.addAnchor(anchor)

            if let entity = model.entity {
                setupEntity(entity, anchor)
            }
        }
    }
}

// MARK: - Private

private extension ARViewController {
    func setupView() {
        view.addSubview(arView)
    }

    func setupLayout() {
        view.addConstraints([
            arView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            arView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            arView.topAnchor.constraint(equalTo: view.topAnchor),
            arView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func setupARView() {
#if !targetEnvironment(simulator)
        guard let referenceImages = ARReferenceImage.referenceImages(
            inGroupNamed: AppConstants.imageGroupName,
            bundle: nil
        ) else {
            fatalError("Missing expected asset catalog resources.")
        }

        arView.session.delegate = self
        arView.automaticallyConfigureSession = false
#endif

        if UserDefaults.isShowingStatistics {
            arView.debugOptions = [.showStatistics]
        } else {
            arView.debugOptions = []
        }

        if UserDefaults.isRenderOptionsEnabled {
            arView.renderOptions = []
        } else {
            arView.renderOptions = [
                .disableAREnvironmentLighting,
                .disableHDR,
                .disableMotionBlur,
                .disableFaceMesh,
                .disableGroundingShadows,
                .disableDepthOfField,
                .disablePersonOcclusion,
                .disableCameraGrain
            ]
        }

        let configuration = ARWorldTrackingConfiguration()

#if !targetEnvironment(simulator)
        if UserDefaults.isUsingQRCode {
            configuration.detectionImages = referenceImages
            configuration.maximumNumberOfTrackedImages = 1
        } else {
            configuration.planeDetection = .horizontal
        }
#endif

        arView.session.run(configuration)
    }

    func loadEntityAsync(name: String, anchor: AnchorEntity) {
        // Load the asset asynchronously
        ModelEntity.loadModelAsync(named: name)
            .sink(receiveCompletion: { error in
                print("Error: \(error)")
            }, receiveValue: { [weak self] entity in
                self?.setupEntity(entity, anchor)
            })
            .store(in: &disposeBag)
    }

    func setupEntity(_ entity: Entity, _ anchor: AnchorEntity) {
        entity.position.x = 0
        entity.position.y = 0
        anchor.addChild(entity)

        if let animation = entity.availableAnimations.first {
            entity.playAnimation(animation.repeat())
        }
    }
}
