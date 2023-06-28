//
//  MenuViewModel.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 28/06/2023.
//

import Combine
import Foundation

/// MVVM ViewModel Template
@MainActor
final class MenuViewModel: ObservableObject {
    @Published var isShowingCameraView = false

    func selectFile() {}

    func useDefaultModel() {
        isShowingCameraView = true
    }
}
