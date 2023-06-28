//
//  MenuView.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 28/06/2023.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        ZStack(alignment: .center) {
            Image(systemName: Constants.imageName)
                .font(Constants.imageFont)

            VStack {
                Spacer()

                Button("Select File") {
                    print("Select file")
                }
                .buttonStyle(.primary)

                Button("Use default model") {
                    print("Use default model")
                }
                .buttonStyle(.secondary)
            }
            .padding()
            .padding(.bottom)
        }
        .edgesIgnoringSafeArea(.all)
    }

    private enum Constants {
        static let imageName = "arkit"
        static let imageFont = Font.system(size: 120, weight: .light)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
