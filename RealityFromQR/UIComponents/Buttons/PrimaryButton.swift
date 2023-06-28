//
//  PrimaryButton.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 28/06/2023.
//

import SwiftUI

struct PrimaryButton: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(height: UIConstants.buttonHeight)
            .padding(.horizontal)
            .frame(maxWidth: .infinity)
            .background(getBackgroundColor(for: configuration))
            .foregroundColor(.white)
            .font(.body)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: UIConstants.buttonCornerRadius
                )
            )
    }

    func getBackgroundColor(for configuration: Configuration) -> Color {
        if configuration.isPressed {
            return Color.blue.opacity(0.5)
        } else {
            return isEnabled ? Color.blue : Color.gray
        }
    }

    private enum Constants {
        static let buttonHeight: CGFloat = 44
        static let cornerRadius: CGFloat = 10
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            Button("Button") {}
                .buttonStyle(.primary)
                .padding()
        }
    }
}

extension ButtonStyle where Self == PrimaryButton {
    static var primary: PrimaryButton {
        PrimaryButton()
    }
}
