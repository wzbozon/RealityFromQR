//
//  ContentView.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 28/06/2023.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView: View {
    var body: some View {
        ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ARViewContainer()
    }
}
