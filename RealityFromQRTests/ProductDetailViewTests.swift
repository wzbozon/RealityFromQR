//
//  ProductDetailViewTests.swift
//  RealityFromQRTests
//
//  Created by Denis Kutlubaev on 15/08/2023.
//

import XCTest
@testable import RealityFromQR

@MainActor
final class ProductDetailViewTests: XCTestCase {

    func testBody() throws {
        let product = Product(id: 0, name: "", modelFileName: "", imageName: "soda.jpg")
        let viewModel = ProductDetailViewModel(product: product)
        let view = ProductDetailView(viewModel: viewModel, isPresented: .constant(true))
        let body = view.body
        XCTAssertNotNil(body)
    }

}
