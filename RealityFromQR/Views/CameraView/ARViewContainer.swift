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

    init(isShowingStatistics: Bool, isRenderOptionsEnabled: Bool) {
        self.isShowingStatistics = isShowingStatistics
        self.isRenderOptionsEnabled = isRenderOptionsEnabled
    }

    func makeUIViewController(context: Context) -> ARViewController {
        let viewController = ARViewController(
            isShowingStatistics: isShowingStatistics,
            isRenderOptionsEnabled: isRenderOptionsEnabled
        )
        return viewController
    }

    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {

    }

    private let isShowingStatistics: Bool
    private let isRenderOptionsEnabled: Bool
}
