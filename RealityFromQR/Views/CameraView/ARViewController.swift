//
//  ARViewController.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 25/06/2023.
//

import ARKit
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
}

// MARK: - ARSessionDelegate

extension ARViewController: ARSessionDelegate {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        guard
            let imageAnchor = anchors[0] as? ARImageAnchor,
            let imageName = imageAnchor.name,
            imageName  == Constants.qrCodeImageName
        else {
            return
        }

        // AnchorEntity(world: imageAnchor.transform) results in anchoring
        // virtual content to the real world.  Content anchored like this
        // will remain in position even if the reference image moves.
        let originalImageAnchor = AnchorEntity(world: imageAnchor.transform)
        if let originalImageMarker = try? makeDrummer() {
            originalImageMarker.position.y = 0
            originalImageMarker.position.x = 0
            originalImageAnchor.addChild(originalImageMarker)
            arView.scene.addAnchor(originalImageAnchor)
        }
    }
}

// MARK: - Private

private extension ARViewController {
    enum Constants {
        static let modelFileName = "drummer.usdz"
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
        arView.debugOptions = [.showStatistics]
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

        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        configuration.maximumNumberOfTrackedImages = 1

        arView.session.run(configuration)
    }

    func makeDrummer() throws -> ModelEntity {
        let modelEntity = try ModelEntity.loadModel(named: Constants.modelFileName)
        return modelEntity
    }
}
