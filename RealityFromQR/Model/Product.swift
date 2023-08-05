//
//  Product.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 30/07/2023.
//

import Foundation
import SwiftUI

struct Product: Hashable, Identifiable {
    let id: Int
    let name: String
    let modelFileName: String
    let imageName: String

    var imageUrl: URL? {
        URL(string: AppConstants.baseURL + imageName)
    }

    var modelUrl: URL? {
        URL(string: AppConstants.baseURL + modelFileName)
    }

    var isDownloading: Bool = false

    private(set) var currentBytes: Int64 = 0
    private(set) var totalBytes: Int64 = 0

    var progress: Double {
        guard totalBytes > 0 else { return 0.0 }
        return Double(currentBytes) / Double(totalBytes)
    }

    mutating func update(currentBytes: Int64, totalBytes: Int64) {
        self.currentBytes = currentBytes
        self.totalBytes = totalBytes
    }

    var savedModelFileURL: URL {
        URL.documentsDirectory
            .appending(path: "\(modelFileName)")
    }
}

extension Product: Decodable {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case modelFileName
        case imageName
    }
}
