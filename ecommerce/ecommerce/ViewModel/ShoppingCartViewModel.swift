//
//  ShoppingCartViewModel.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 22/09/20.
//

import SwiftUI

class ShoppingCart: ObservableObject {
    @Published var products = [Product]()
    
    func getTotal() -> Float {
        var total = Float.zero
        for item in products {
            total += item.price * Float(item.ammount)
        }
        return total
    }
    
    func placeOrder(product: Product, maxOrders: Int) {
        if let index = products.firstIndex(where: { $0.name == product.name }) {
            products[index].ammount = products[index].ammount + product.ammount >= maxOrders ? maxOrders : products[index].ammount + product.ammount
        } else {
            products.insert(product, at: 0)
        }
    }
}
