//
//  ProductsList.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 23/09/20.
//

import SwiftUI

struct ProductsList: View {
    var productList: [Product]
    var shoppingCart: ShoppingCart
    var body: some View {
        List(productList, id: \.id) { product in
            if product.ammount > 0 {
                NavigationLink(destination: BuyProductPage(cart: shoppingCart, product: product)) {
                    BuyCard(product: product)
                        .padding()
                }
            }
        }
    }
}

struct ProductsList_Previews: PreviewProvider {
    static var previews: some View {
        ProductsList(productList: DataManagerViewModel().productList, shoppingCart: ShoppingCart())
    }
}
