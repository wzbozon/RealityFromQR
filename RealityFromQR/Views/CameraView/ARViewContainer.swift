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

    init(isShowingStatistics: Bool) {
        self.isShowingStatistics = isShowingStatistics
    }

    func makeUIViewController(context: Context) -> ARViewController {
        let viewController = ARViewController(isShowingStatistics: isShowingStatistics)
        return viewController
    }

    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {

    }

    private let isShowingStatistics: Bool
}
