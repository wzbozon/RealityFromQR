//
//  ProductList.swift
//  RealityFromQR
//
//  Created by Denis Kutlubaev on 30/07/2023.
//

import SwiftUI

struct ProductList: View {
    var body: some View {
        List(products) { product in
            ProductRow(product: product)
        }
    }
}

struct ProductList_Previews: PreviewProvider {
    static var previews: some View {
        ProductList()
    }
}
