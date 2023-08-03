//
//  ProductDetailView.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 03/08/2023.
//

import SwiftUI

struct ProductDetailView: View {
    let product: Product

    var body: some View {
        AsyncImage(url: product.imageUrl) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            ProgressView()
        }

        Text(product.name)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductDetailView(product: products[0])
        }
    }
}
