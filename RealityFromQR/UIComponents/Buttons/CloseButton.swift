//
//  CloseButton.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 28/06/2023.
//

import SwiftUI

struct CloseButton: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var color: Color = .blue
    var action: (() -> Void)?

    var body: some View {
        HStack {
            Spacer()

            Button(action: {
                if let action {
                    action()
                } else {
                    presentationMode.wrappedValue.dismiss()
                }
            }, label: {
                Image(systemName: "xmark")
                    .font(.headline)
                    .foregroundColor(color)
                    .frame(
                        width: UIConstants.buttonHeight,
                        height: UIConstants.buttonHeight
                    )
                    .tag(Constants.imageTag)
            })
            .padding(.trailing)
            .tag(Constants.buttonTag)
        }
    }

    enum Constants {
        static let imageTag = 1
        static let buttonTag = 2
    }
}

#if !TESTING
struct CloseButton_Previews: PreviewProvider {
    static var previews: some View {
        CloseButton()
    }
}
#endif
