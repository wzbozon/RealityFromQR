//
//  CameraViewTests.swift
//  ViewInARTests
//
//  Created by Denis Kutlubaev on 02/09/2023.
//

import XCTest
import ViewInspector
import SwiftUI
@testable import ViewInAR

final class CameraViewTests: XCTestCase {
    func testBody() throws {
        let sut = CameraView()
        let body = sut.body
        XCTAssertNotNil(body)

        let zStack = try sut.inspect().zStack()
        XCTAssertNotNil(zStack)

        let container = try sut.inspect().findAll(ARViewContainer.self).first
        XCTAssertNil(container) // On Simulator must be nil
    }
}
