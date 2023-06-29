//
//  MenuViewModel.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 28/06/2023.
//

import ARKit
import Combine
import Foundation
import RealityKit

/// MVVM ViewModel Template
@MainActor
final class MenuViewModel: ObservableObject {
    @Published var isShowingCameraView = false
    @Published var isShowingFileImporter = false

    func selectFileTapped() {
        isShowingFileImporter = true
    }

    func useDefaultModelTapped() {
        isShowingCameraView = true
    }

    func handlePickedFile(_ url: URL) {
        print("Did select file: \(url)")

        do {
            model.entity = try Entity.load(contentsOf: url)
            print("Model loaded")
            isShowingCameraView = true
        } catch {
            print("Fail loading entity.")
        }
    }

    private let model = Model.shared
}
