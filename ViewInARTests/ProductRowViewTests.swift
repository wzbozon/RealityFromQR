//
//  ProductRowViewTests.swift
//  ViewInARTests
//
//  Created by Denis Kutlubaev on 02/09/2023.
//

import XCTest
import ViewInspector
import SwiftUI
@testable import ViewInAR

final class ProductRowViewTests: XCTestCase {
    func testProductRowView() throws {
        let sut = ProductRowView(
            product: .init(
                id: 0,
                name: "Product",
                modelFileName: "model.usdz",
                imageName: "model.jpg"
            )
        )

        let text = try sut.inspect().find(text: "Product")
        XCTAssertNotNil(text)

        let image = try sut.inspect().find(viewWithTag: ProductRowView.Constants.imageTag)
        XCTAssertNotNil(image)
    }
}
