//
//  DeferView.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 28/06/2023.
//

import SwiftUI

/// Used to postpone creation of a View in NavigationLink using ViewBuilder
struct DeferView<Content: View>: View {
    let content: () -> Content

    init(@ViewBuilder _ content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        content()
    }
}
