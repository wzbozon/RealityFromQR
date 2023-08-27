//
//  CloseButtonTests.swift
//  RealityFromQRTests
//
//  Created by Denis Kutlubaev on 24/08/2023.
//

import XCTest
import ViewInspector
import SwiftUI
@testable import ViewInAR

final class CloseButtonTests: XCTestCase {
    func testButton() throws {
        var didTapCloseButton = false

        let sut = CloseButton {
            didTapCloseButton = true
        }

        let image = try sut.inspect().find(viewWithTag: CloseButton.Constants.imageTag)
        XCTAssertNotNil(image)

        try sut.inspect().hStack().button(1).tap()
        XCTAssertTrue(didTapCloseButton)
    }
}
