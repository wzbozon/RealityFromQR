//
//  ModelDataTests.swift
//  RealityFromQRTests
//
//  Created by Denis Kutlubaev on 14/08/2023.
//

import XCTest
@testable import ViewInAR

final class ModelDataTests: XCTestCase {

    func testLoadModelDataFileNotFound() {
        var thrownError: Error?

        XCTAssertThrowsError(try ModelData.load("test.json") as [Product]) {
            thrownError = $0
        }

        XCTAssertTrue(
            thrownError is ModelDataError,
            "Unexpected error type: \(type(of: thrownError))"
        )

        XCTAssertEqual(
            thrownError as? ModelDataError,
            .fileNotFound("Couldn't find test.json in main bundle.")
        )

        XCTAssertNotEqual(
            thrownError as? ModelDataError,
            .fileNotParsed("")
        )
    }

    func testLoadModelDataFileNotParsed() {
        var thrownError: Error?

        XCTAssertThrowsError(try ModelData.load("products-corrupt.json") as [Product]) {
            thrownError = $0
        }

        XCTAssertTrue(
            thrownError is ModelDataError,
            "Unexpected error type: \(type(of: thrownError))"
        )

        XCTAssertEqual(
            thrownError as? ModelDataError,
            .fileNotParsed("")
        )
    }

    func testLoadModelData() throws {
        let products: [Product] = try ModelData.load("products.json")
        XCTAssertFalse(products.isEmpty)
    }

}
