//
//  Product.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 30/07/2023.
//

import Foundation
import SwiftUI

struct Product: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
    let modelFileName: String
    let imageName: String

    var imageUrl: URL? {
        URL(string: "http://ar.alwawee.ru/" + imageName)
    }
}
