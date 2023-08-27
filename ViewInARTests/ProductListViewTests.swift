//
//  ProductListViewTests.swift
//  RealityFromQRTests
//
//  Created by Denis Kutlubaev on 15/08/2023.
//

import XCTest
@testable import ViewInAR

final class ProductListViewTests: XCTestCase {

    func testBody() throws {
        let view = ProductListView(productId: 0)
        XCTAssertEqual(view.productId, 0)
        let body = view.body
        XCTAssertNotNil(body)
    }

}
