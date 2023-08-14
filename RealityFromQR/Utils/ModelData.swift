//
//  ModelData.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 30/07/2023.
//

import Foundation

enum ModelDataError: Error, Equatable {
    case fileNotFound(String)
    case fileNotLoaded(String)
}

class ModelData {
    // swiftlint:disable force_try
    static var products: [Product] = try! ModelData.load("products.json")

    static func load<T: Decodable>(_ filename: String) throws -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            throw ModelDataError.fileNotFound("Couldn't find \(filename) in main bundle.")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            throw ModelDataError.fileNotLoaded("Couldn't load \(filename) from main bundle:\n\(error)")
        }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }
}
