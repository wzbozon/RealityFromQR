//
//  CameraView.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 28/06/2023.
//

import SwiftUI
import RealityKit
import ARKit

struct CameraView: View {
    var body: some View {
        ZStack {
#if !targetEnvironment(simulator)
            ARViewContainer()
                .edgesIgnoringSafeArea(.all)
#endif
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
