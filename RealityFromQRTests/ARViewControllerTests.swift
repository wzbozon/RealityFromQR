//
//  ARViewControllerTests.swift
//  RealityFromQRTests
//
//  Created by Denis Kutlubaev on 14/08/2023.
//

import XCTest
import ARKit
import RealityKit
@testable import RealityFromQR

final class ARViewControllerTests: XCTestCase {

    var viewController: ARViewController!
    var userDefaults: UserDefaults!
    var preferences: Preferences!
    let model = Model.shared

    override func setUpWithError() throws {
        userDefaults = UserDefaults(suiteName: #file)
        userDefaults.removePersistentDomain(forName: #file)
        preferences = Preferences(container: userDefaults)
    }

    override func tearDownWithError() throws {
        viewController = nil
        let entity: Entity? = nil
        model.entity = entity
    }

    func testViewDidLoad() throws {
        viewController = ARViewController(preferences: preferences)
        XCTAssertFalse(viewController.didSetupView)
        viewController = ARViewController(preferences: preferences)
        viewController.viewDidLoad()
        XCTAssertTrue(viewController.didSetupView)
    }

    func testSessionDidAddAnchorsNoQRCode() throws {
        userDefaults.set(false, forKey: UDKey.isUsingQRCode)
        viewController = ARViewController(preferences: preferences)

        guard let url = Bundle.main.url(forResource: AppConstants.defaultModelFileName, withExtension: nil) else {
            throw URLError(.badURL)
        }
        model.entity = try Entity.load(contentsOf: url)

        let session = ARSession()
        let matrix = simd_float4x4([
            [0.0, 0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0, 0.0]
        ])
        let anchors: [ARAnchor] = [ARPlaneAnchor(anchor: .init(transform: matrix))]
        viewController.session(session, didAdd: anchors)

        XCTAssertEqual(viewController.arView.scene.anchors.count, 1)
        XCTAssertTrue(viewController.didSetupEntity)
    }

    func testSessionDidAddAnchorsWithQRCode() throws {
        userDefaults.set(true, forKey: UDKey.isUsingQRCode)
        viewController = ARViewController(preferences: preferences)

        guard let url = Bundle.main.url(forResource: AppConstants.defaultModelFileName, withExtension: nil) else {
            throw URLError(.badURL)
        }
        model.entity = try Entity.load(contentsOf: url)

        let session = ARSession()
        let matrix = simd_float4x4([
            [0.0, 0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0, 0.0]
        ])

        let planeAnchor = ARPlaneAnchor(anchor: .init(transform: matrix))
        let anchors: [ARAnchor] = [planeAnchor]

        viewController.session(session, didAdd: anchors)

        XCTAssertEqual(viewController.arView.scene.anchors.count, 0)
        XCTAssertFalse(viewController.didSetupEntity)
    }

    func testLoadEntityAsync() throws {
        viewController = ARViewController(preferences: preferences)

        let matrix = simd_float4x4([
            [0.0, 0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0, 0.0],
            [0.0, 0.0, 0.0, 0.0]
        ])

        let planeAnchor = ARPlaneAnchor(anchor: .init(transform: matrix))
        let anchor = AnchorEntity(world: planeAnchor.transform)
        let expectation = self.expectation(description: "")
        viewController.loadEntityAsync(
            name: AppConstants.defaultModelFileName,
            anchor: anchor,
            onSuccess: {
                expectation.fulfill()
            }
        )
        waitForExpectations(timeout: 1)
        XCTAssertTrue(viewController.didSetupEntity)
    }

}
