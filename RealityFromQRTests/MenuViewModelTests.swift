//
//  MenuViewModelTests.swift
//  RealityFromQRTests
//
//  Created by Denis Kutlubaev on 14/08/2023.
//

import XCTest
import RealityKit
@testable import RealityFromQR

@MainActor
final class MenuViewModelTests: XCTestCase {

    var viewModel: MenuViewModel!
    let model = Model.shared

    override func setUp() {
        viewModel = MenuViewModel()
    }

    override func tearDown() {
        viewModel = nil

        let entity: Entity? = nil
        model.entity = entity
    }

    func testSelectFileTapped() {
        viewModel.selectFileTapped()
        XCTAssertTrue(viewModel.isShowingFileImporter)
    }

    func testUseDefaultModelTapped() {
        viewModel.useDefaultModelTapped()
        XCTAssertTrue(viewModel.isShowingCameraView)
    }

    func testProductListTapped() {
        viewModel.productListTapped()
        XCTAssertTrue(viewModel.isShowingProductList)
    }

    func testHandlePickedFile() throws {
        guard let url = Bundle.main.url(forResource: AppConstants.defaultModelFileName, withExtension: nil) else {
            throw URLError(.badURL)
        }

        XCTAssertNil(model.entity)

        viewModel.handlePickedFile(url)

        XCTAssertNotNil(model.entity)
    }

    func testHandleFileImporterSuccessResult() throws {
        guard let url = Bundle.main.url(forResource: AppConstants.defaultModelFileName, withExtension: nil) else {
            throw URLError(.badURL)
        }

        XCTAssertNil(model.entity)

        let result: Result<[URL], Error> = .success([url])

        viewModel.handleFileImporterResult(result)

        XCTAssertNotNil(model.entity)
    }

    func testHandleFileImporterErrorResult() throws {
        XCTAssertNil(model.entity)

        let error = URLError(.notConnectedToInternet)
        let result: Result<[URL], Error> = .failure(error)

        viewModel.handleFileImporterResult(result)

        XCTAssertNil(model.entity)
    }

}
