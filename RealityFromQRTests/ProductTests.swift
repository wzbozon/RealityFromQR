//
//  ProductTests.swift
//  RealityFromQRTests
//
//  Created by Denis Kutlubaev on 13/08/2023.
//

import XCTest
@testable import RealityFromQR

final class ProductTests: XCTestCase {

    var product: Product!

    override func setUp() {
        product = Product(id: 0, name: "Test", modelFileName: "model.usdz", imageName: "image.jpg")
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

    func testModelUrl() throws {
        guard let url = product.modelUrl?.absoluteString else {
            XCTFail("No URL")
            return
        }
        XCTAssertEqual(url, "http://ar.alwawee.ru/model.usdz")
    }

}
