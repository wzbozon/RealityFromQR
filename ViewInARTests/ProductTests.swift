//
//  ProductTests.swift
//  RealityFromQRTests
//
//  Created by Denis Kutlubaev on 13/08/2023.
//

import XCTest
@testable import ViewInAR

final class ProductTests: XCTestCase {

    var product: Product!

    override func setUp() {
        product = Product(
            id: 0,
            name: "Test",
            modelFileName: "model.usdz",
            imageName: "image.jpg"
        )
    }

    override func tearDown() {
        product = nil
    }

    func testImageUrl() {
        guard let url = product.imageUrl?.absoluteString else {
            XCTFail("No URL")
            return
        }
        XCTAssertEqual(url, "http://ar.alwawee.ru/image.jpg")
    }

    func testModelUrl() {
        guard let url = product.modelUrl?.absoluteString else {
            XCTFail("No URL")
            return
        }
        XCTAssertEqual(url, "http://ar.alwawee.ru/model.usdz")
    }

    func testProgress() {
        XCTAssertEqual(product.progress, 0)

        product.update(currentBytes: 50, totalBytes: 100)
        XCTAssertEqual(product.progress, 0.5)

        product.update(currentBytes: 60, totalBytes: 60)
        XCTAssertEqual(product.progress, 1.0)
    }

    func testSavedModelFileURL() {
        XCTAssertFalse(product.savedModelFileURL.absoluteString.isEmpty)
        XCTAssertTrue(product.savedModelFileURL.isFileURL)
        XCTAssertEqual(product.savedModelFileURL.lastPathComponent, "model.usdz")
    }

}
