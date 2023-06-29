//
//  Model.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 29/06/2023.
//

import Foundation
import RealityKit

class Model {
    static let shared = Model()
    private init() {}

    var entity: Entity?
}
