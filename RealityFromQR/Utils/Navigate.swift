//
//  Navigate.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 28/06/2023.
//

import SwiftUI

struct Navigate<Destination: View>: View {
    @Binding var when: Bool
    var destination: () -> Destination

    var body: some View {
        NavigationLink(isActive: $when) {
            DeferView {
                destination()
            }
        } label: { }
    }
}
