//
//  ViewController.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 25/06/2023.
//

import ARKit
import RealityKit
import UIKit

class ViewController: UIViewController {

    @IBOutlet var arView: ARView!

    let ballRadius: Float = 0.03

    override func viewDidLoad() {
        super.viewDidLoad()

        /*
         // Load the "Box" scene from the "Experience" Reality File
         let boxAnchor = try! Experience.loadBox()

         // Add the box anchor to the scene
         arView.scene.anchors.append(boxAnchor)
         */

        /*
         let imageAnchor = AnchorEntity(.image(group: "AR Resources", name: "qrcode"))
         arView.scene.addAnchor(imageAnchor)

         let box = MeshResource.generateBox(size: 0.3, cornerRadius: 0.03)
         let metal = SimpleMaterial(color: .gray, isMetallic: true)
         let model = try ModelEntity(mesh: box, materials: [metal])
         imageAnchor.addChild(model)
         */

        guard let referenceImages = ARReferenceImage.referenceImages(
            inGroupNamed: "AR Resources", bundle: nil) else {
            fatalError("Missing expected asset catalog resources.")
        }

        arView.session.delegate = self
        arView.automaticallyConfigureSession = false

        /*
        arView.debugOptions = [.showStatistics]
        arView.renderOptions = [.disableCameraGrain, .disableHDR,
                                .disableMotionBlur, .disableDepthOfField,
                                .disableFaceOcclusions, .disablePersonOcclusion,
                                .disableGroundingShadows, .disableAREnvironmentLighting]
        */

        let configuration = ARWorldTrackingConfiguration()
        configuration.detectionImages = referenceImages
        configuration.maximumNumberOfTrackedImages = 1

        arView.session.run(configuration)
    }

    func makeBall(radius: Float, color: UIColor) -> ModelEntity {
        let ball = ModelEntity(mesh: .generateSphere(radius: radius),
                               materials: [SimpleMaterial(color: color, isMetallic: false)])
        return ball
    }

    func makeDrummer() -> ModelEntity? {
        let filename = "drummer" + ".usdz"
        let modelEntity = try? ModelEntity.loadModel(named: filename)
        return modelEntity
    }
}

// MARK: - ARSessionDelegate

extension ViewController: ARSessionDelegate {
    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
        guard let imageAnchor = anchors[0] as? ARImageAnchor else { return }

        if let imageName = imageAnchor.name, imageName  == "qrcode" {

            // AnchorEntity(world: imageAnchor.transform) results in anchoring
            // virtual content to the real world.  Content anchored like this
            // will remain in position even if the reference image moves.
            let originalImageAnchor = AnchorEntity(world: imageAnchor.transform)
            // let originalImageMarker = makeBall(radius: ballRadius, color: .systemPink)
            if let originalImageMarker = makeDrummer() {
                originalImageMarker.position.y = 0.2
                originalImageMarker.position.x = 0.2
                originalImageAnchor.addChild(originalImageMarker)
                arView.scene.addAnchor(originalImageAnchor)
            }

            /*
             // AnchorEntity(anchor: imageAnchor) results in anchoring
             // virtual content to the ARImageAnchor that is attached to the
             // reference image.  Content anchored like this will appear
             // stuck to the reference image.
             let currentImageAnchor = AnchorEntity(anchor: imageAnchor)
             let currentImageMarker = makeBall(radius: ballRadius, color: .systemTeal)
             currentImageMarker.position.y = ballRadius
             currentImageAnchor.addChild(currentImageMarker)
             arView.scene.addAnchor(currentImageAnchor)
             */
        }
    }
}
