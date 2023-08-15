//
//  UserDefaults.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 05/08/2023.
//

import Foundation

class Preferences {
    init(container: UserDefaults = UserDefaults.standard) {
        _isShowingStatistics.container = container
        _isRenderOptionsEnabled.container = container
        _isUsingQRCode.container = container
    }

    @UserDefault(key: UDKey.isShowingStatistics, defaultValue: false)
    var isShowingStatistics: Bool

    @UserDefault(key: UDKey.isRenderOptionsEnabled, defaultValue: false)
    var isRenderOptionsEnabled: Bool

    @UserDefault(key: UDKey.isUsingQRCode, defaultValue: false)
    var isUsingQRCode: Bool
}
