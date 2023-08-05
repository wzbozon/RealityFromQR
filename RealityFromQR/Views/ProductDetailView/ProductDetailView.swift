//
//  ProductDetailView.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 03/08/2023.
//

import SwiftUI

struct ProductDetailView: View {
    @StateObject private var viewModel: ProductDetailViewModel

    init(viewModel: ProductDetailViewModel, isPresented: Binding<Bool>) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: viewModel.product.imageUrl) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }

            Text(viewModel.product.name)

            Button {
                viewModel.downloadFileTapped()
            } label: {
                if viewModel.product.isDownloading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                } else {
                    Text("View in AR")
                }
            }
            .buttonStyle(.primary)
            .disabled(viewModel.product.isDownloading)

            ProgressView(value: viewModel.progress)
                .opacity(viewModel.progress > 0 && viewModel.progress < 1.0 ? 1 : 0)

            Navigate(when: $viewModel.isShowingCameraView) {
                CameraView()
            }
        }
        .padding(.horizontal, 20)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductDetailView(
                viewModel: ProductDetailViewModel(product: products[0]),
                isPresented: .constant(true)
            )
        }
    }
}
