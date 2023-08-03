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

            Button("View in AR") {
                viewModel.downloadFileTapped()
            }
            .buttonStyle(.primary)

            Navigate(when: $viewModel.isShowingCameraView) {
                CameraView(
                    isShowingStatistics: false,
                    isRenderOptionsEnabled: false,
                    isUsingQRCode: false
                )
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
