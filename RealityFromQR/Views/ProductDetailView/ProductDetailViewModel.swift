//
//  ProductDetailViewModel.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 03/08/2023.
//

import ARKit
import Combine
import Foundation
import RealityKit

@MainActor
final class ProductDetailViewModel: NSObject, ObservableObject {
    @Published var isShowingCameraView = false

    let product: Product

    private lazy var downloadSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        return URLSession(configuration: configuration, delegate: nil, delegateQueue: .main)
    }()

    init(product: Product) {
        self.product = product
    }

    @MainActor
    func fetchARModel() async throws {
        guard let url = URL(string: AppConstants.baseURL + product.modelFileName) else {
            print("Error: invalid AR model URL")
            return
        }

        do {
            let tuple = try await URLSession.shared.download(from: url)
            let destinationURL = tuple.0
            let newURL = destinationURL.deletingPathExtension().appendingPathExtension("usdz")
            try FileManager.default.moveItem(at: destinationURL, to: newURL)

            model.entity = try Entity.load(contentsOf: newURL)
            print("Model loaded")

            // Show CameraView, it will setup ARView with a scene / entity in Model
            isShowingCameraView = true
        } catch {
            print("Failed to load entity. Error: \(error)")
        }
    }

    func downloadFileTapped() {
        Task {
            try? await fetchARModel()
        }
    }

    private let model = Model.shared
}
