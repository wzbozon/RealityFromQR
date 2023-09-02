//
//  ProductRowView.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 30/07/2023.
//

import SwiftUI

struct ProductRowView: View {
    var product: Product

    var body: some View {
        HStack {
            AsyncImage(url: product.imageUrl) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)
            .tag(Constants.imageTag)

            Text(product.name)

            Spacer()
        }
    }

    enum Constants {
        static let imageTag = 1
    }
}

#if !TESTING
struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRowView(product: ModelData.products[0])
    }
}
#endif
