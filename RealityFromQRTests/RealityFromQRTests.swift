//
//  RealityFromQRTests.swift
//  RealityFromQRTests
//
//  Created by Denis Kutlubaev on 25/06/2023.
//

import XCTest
@testable import RealityFromQR

final class RealityFromQRTests: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let product = Product(id: 0, name: "Test", modelFileName: "test.usdz", imageName: "test.jpg")
        guard let url = product.imageUrl?.absoluteString else {
            XCTFail("No URL")
            return
        }
        XCTAssertEqual(url, "http://ar.alwawee.ru/test.jpg")
    }
}
