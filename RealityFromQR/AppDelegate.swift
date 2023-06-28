//
//  AppDelegate.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 25/06/2023.
//

import UIKit
import SwiftUI

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // Create the SwiftUI view that provides the window contents.
        let menuView = MenuView(
            viewModel: MenuViewModel(),
            isPresented: .constant(true)
        )

        // Use a UIHostingController as window root view controller.
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIHostingController(rootView: menuView)
        self.window = window
        window.makeKeyAndVisible()

        return true
    }
}
