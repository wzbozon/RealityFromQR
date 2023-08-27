//
//  ProductListView.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 30/07/2023.
//

import SwiftUI

struct ProductListView: View {
    @State var productId: Int?
    @State var isShowingProductDetailView = false

    var body: some View {
        List(ModelData.products) { product in
            NavigationLink(tag: product.id, selection: self.$productId) {
                ProductDetailView(
                    viewModel: ProductDetailViewModel(product: product),
                    isPresented: $isShowingProductDetailView
                )
            } label: {
                ProductRowView(product: product)
            }
        }
    }
}

#if !TESTING
struct ProductList_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView(productId: 0)
    }
}
#endif
