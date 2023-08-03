//
//  ARViewContainer.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 28/06/2023.
//

import ARKit
import RealityKit
import SwiftUI
import UIKit

struct ARViewContainer: UIViewControllerRepresentable {
    typealias UIViewControllerType = ARViewController

    init(isShowingStatistics: Bool, isRenderOptionsEnabled: Bool, isUsingQRCode: Bool) {
        self.isShowingStatistics = isShowingStatistics
        self.isRenderOptionsEnabled = isRenderOptionsEnabled
        self.isUsingQRCode = isUsingQRCode
    }

    func makeUIViewController(context: Context) -> ARViewController {
        let viewController = ARViewController(
            isShowingStatistics: isShowingStatistics,
            isRenderOptionsEnabled: isRenderOptionsEnabled,
            isUsingQRCode: isUsingQRCode
        )
        return viewController
    }

    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {

    }

    private let isShowingStatistics: Bool
    private let isRenderOptionsEnabled: Bool
    private let isUsingQRCode: Bool
}
