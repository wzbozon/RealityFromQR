//
//  ProductDetailViewModelTests.swift
//  RealityFromQRTests
//
//  Created by Denis Kutlubaev on 26/08/2023.
//

import XCTest
@testable import ViewInAR

@MainActor
final class ProductDetailViewModelTests: XCTestCase {

    var product: Product!
    var sut: ProductDetailViewModel!

    override func setUp() async throws {
        product = Product(id: 0, name: "", modelFileName: "", imageName: "soda.jpg")
        sut = ProductDetailViewModel(product: product)
    }

    override func tearDown() async throws {}

    func testFetchARModel() async {
        try? await sut.fetchARModel()
        XCTAssertFalse(product.isDownloading)
    }

}
