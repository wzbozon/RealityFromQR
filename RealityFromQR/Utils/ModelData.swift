//
//  ModelData.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 30/07/2023.
//

import Foundation

enum ModelDataError: Error, Equatable {
    case fileNotFound(String)
    case fileNotParsed(String)

    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.fileNotFound, .fileNotFound):
            return true
        case (.fileNotParsed, .fileNotParsed):
            return true
        default:
            return false
        }
    }
}

class ModelData {
    // swiftlint:disable force_try
    static var products: [Product] = try! ModelData.load("products.json")

    static func load<T: Decodable>(_ filename: String) throws -> T {
        guard
            let file = Bundle.main.url(
                forResource: filename,
                withExtension: nil
            ),
            let data = try? Data(contentsOf: file)
        else {
            throw ModelDataError.fileNotFound(
                "Couldn't find \(filename) in main bundle."
            )
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            throw ModelDataError.fileNotParsed(
                "Couldn't parse \(filename) as \(T.self):\n\(error)"
            )
        }
    }
}
