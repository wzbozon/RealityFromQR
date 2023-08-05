//
//  UserDefaults.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 05/08/2023.
//

import Foundation

extension UserDefaults {
    @UserDefault(key: UDKey.isShowingStatistics, defaultValue: false)
    static var isShowingStatistics: Bool

    @UserDefault(key: UDKey.isRenderOptionsEnabled, defaultValue: false)
    static var isRenderOptionsEnabled: Bool

    @UserDefault(key: UDKey.isUsingQRCode, defaultValue: false)
    static var isUsingQRCode: Bool
}
