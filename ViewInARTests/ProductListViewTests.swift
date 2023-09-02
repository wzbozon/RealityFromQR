//
//  ProductListViewTests.swift
//  RealityFromQRTests
//
//  Created by Denis Kutlubaev on 15/08/2023.
//

import XCTest
import ViewInspector
import SwiftUI
@testable import ViewInAR

final class ProductListViewTests: XCTestCase {
    func testBody() throws {
        let sut = ProductListView(productId: 0)
        XCTAssertEqual(sut.productId, 0)
        let body = sut.body
        XCTAssertNotNil(body)

        let list = try sut.inspect().list()
        XCTAssertNotNil(list)

        XCTAssertFalse(sut.isShowingProductDetailView)
        let navigationLink = try sut.inspect().findAll(ViewType.NavigationLink.self).first
        XCTAssertNotNil(navigationLink)

        let productRowView = try sut.inspect().find(ProductRowView.self, containing: "Pizza")
        XCTAssertNotNil(productRowView)
    }
}
