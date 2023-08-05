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
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupLayout()
        setupARView()
    }

    private lazy var arView: ARView = {
        let view = ARView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()

    private var disposeBag = Set<AnyCancellable>()
    private let model = Model.shared
}

// MARK: - ARSessionDelegate

extension ARViewController: ARSessionDelegate {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        if UserDefaults.isUsingQRCode {
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

        if UserDefaults.isUsingQRCode {
            configuration.detectionImages = referenceImages
            configuration.maximumNumberOfTrackedImages = 1
        } else {
            configuration.planeDetection = .horizontal
        }

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
