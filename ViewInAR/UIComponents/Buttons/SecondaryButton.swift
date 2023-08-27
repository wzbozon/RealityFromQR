//
//  SecondaryButton.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 28/06/2023.
//

import SwiftUI

struct SecondaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity)
            .frame(height: UIConstants.buttonHeight)
            .padding(.horizontal)
            .background(Color.white.opacity(0.01))
            .font(.body)
            .foregroundColor(
                configuration.isPressed ? pressedColor : defaultColor
            )
            .overlay(
                RoundedRectangle(cornerRadius: UIConstants.buttonCornerRadius)
                    .stroke(
                        configuration.isPressed ? pressedColor : defaultColor, lineWidth: 1
                    )
            )
    }

    private let defaultColor: Color = .black
    private let pressedColor: Color = .black.opacity(0.5)
}

#if !TESTING
struct SecondaryButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            VStack {
                Button("Hello World!") {}
                    .buttonStyle(.secondary)
                    .padding()
            }
        }
    }
}
#endif

extension ButtonStyle where Self == SecondaryButton {
    static var secondary: SecondaryButton {
        SecondaryButton()
    }
}
