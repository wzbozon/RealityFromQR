//
//  MenuView.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 28/06/2023.
//

import SwiftUI

struct MenuView: View {
    @StateObject private var viewModel: MenuViewModel

    init(viewModel: MenuViewModel, isPresented: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ZStack(alignment: .center) {
            Image(systemName: Constants.imageName)
                .font(Constants.imageFont)

            VStack {
                Spacer()

                Button("Select File") {
                    viewModel.selectFileTapped()
                }
                .buttonStyle(.primary)

                Button("Use default model") {
                    viewModel.useDefaultModelTapped()
                }
                .buttonStyle(.secondary)
            }
            .padding()
            .padding(.bottom)
        }
        .edgesIgnoringSafeArea(.all)
        .fullScreenCover(isPresented: $viewModel.isShowingCameraView) {
            CameraView()
        }
        .fileImporter(
            isPresented: $viewModel.isShowingFileImporter,
            allowedContentTypes: [.usdz, .realityFile],
            allowsMultipleSelection: false
        ) { result in
            switch result {
            case .success(let files):
                files.forEach { file in
                    guard file.startAccessingSecurityScopedResource() else {
                        print("Error: no access")
                        return
                    }

                    viewModel.handlePickedFile(file)

                    file.stopAccessingSecurityScopedResource()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

    private enum Constants {
        static let imageName = "arkit"
        static let imageFont = Font.system(size: 120, weight: .light)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(
            viewModel: .init(),
            isPresented: .constant(false)
        )
    }
}
