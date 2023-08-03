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
final class ProductDetailViewModel: ObservableObject {
    @Published var isShowingCameraView = false

    let product: Product

    init(product: Product) {
        self.product = product
    }

    func downloadFileTapped() {

    }

    func handlePickedFile(_ url: URL) {
        print("Did select file: \(url)")

        do {
            var url = url
            // Load usdz files directly
            // For reality files append a scene name
            if url.pathExtension == "reality" {
                url = url.appendingPathComponent(AppConstants.sceneName, isDirectory: false)
            }

            model.entity = try Entity.load(contentsOf: url)
            print("Model loaded")

            // Show CameraView, it will setup ARView with a scene / entity in Model
            isShowingCameraView = true
        } catch {
            print("Failed to load entity. Error: \(error)")
        }
    }

    private let model = Model.shared
}
