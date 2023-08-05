//
//  UserDefault.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 05/08/2023.
//

import Foundation

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}

extension UserDefaults {
    @UserDefault(key: UDKey.isShowingStatistics, defaultValue: false)
    static var isShowingStatistics: Bool

    @UserDefault(key: UDKey.isRenderOptionsEnabled, defaultValue: false)
    static var isRenderOptionsEnabled: Bool

    @UserDefault(key: UDKey.isUsingQRCode, defaultValue: false)
    static var isUsingQRCode: Bool
}
