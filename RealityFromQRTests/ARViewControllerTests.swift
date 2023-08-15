//
//  ARViewControllerTests.swift
//  RealityFromQRTests
//
//  Created by Denis Kutlubaev on 14/08/2023.
//

import XCTest
import ARKit
@testable import RealityFromQR

final class ARViewControllerTests: XCTestCase {

    var viewController: ARViewController!
    var userDefaults: UserDefaults!
    var preferences: Preferences!

    override func setUpWithError() throws {
        userDefaults = UserDefaults(suiteName: #file)
        userDefaults.removePersistentDomain(forName: #file)
        preferences = Preferences(container: userDefaults)
    }

    override func tearDownWithError() throws {
        viewController = nil
    }

    func testViewDidLoad() throws {
        viewController = ARViewController(preferences: preferences)
        XCTAssertFalse(viewController.didSetupView)
        viewController = ARViewController(preferences: preferences)
        viewController.viewDidLoad()
        XCTAssertTrue(viewController.didSetupView)
    }

    func testSessionDidAddAnchors() {
        userDefaults.set(false, forKey: UDKey.isUsingQRCode)
        viewController = ARViewController(preferences: preferences)

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
    }

}
