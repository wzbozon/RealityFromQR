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
    init(isShowingStatistics: Bool, isRenderOptionsEnabled: Bool) {
        self.isShowingStatistics = isShowingStatistics
        self.isRenderOptionsEnabled = isRenderOptionsEnabled
        super.init(nibName: nil, bundle: nil)
        print("[ARViewController] init")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLayout()
        setupARView()
    }

    deinit {
        print("[ARViewController] deinit")
    }

    private lazy var arView: ARView = {
        let view = ARView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private var disposeBag = Set<AnyCancellable>()
    private let model = Model.shared
    private let isShowingStatistics: Bool
    private let isRenderOptionsEnabled: Bool
}

// MARK: - ARSessionDelegate

extension ARViewController: ARSessionDelegate {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        guard
            let imageAnchor = anchors[0] as? ARImageAnchor,
            let imageName = imageAnchor.name,
            imageName == Constants.qrCodeImageName
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
            loadEntityAsync(name: Constants.defaultModelFileName, anchor: originalImageAnchor)
        }
    }
}

// MARK: - Private

private extension ARViewController {
    enum Constants {
        static let defaultModelFileName = "drummer.usdz"
        static let qrCodeImageName = "qrcode"
        static let imageGroupName = "AR Resources"
    }

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
        guard let referenceImages = ARReferenceImage.referenceImages(
            inGroupNamed: Constants.imageGroupName,
            bundle: nil
        ) else {
            fatalError("Missing expected asset catalog resources.")
        }

        arView.session.delegate = self
        arView.automaticallyConfigureSession = false

        if isShowingStatistics {
            arView.debugOptions = [.showStatistics]
        } else {
            arView.debugOptions = []
        }

        if isRenderOptionsEnabled {
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
        configuration.detectionImages = referenceImages
        configuration.maximumNumberOfTrackedImages = 1

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
