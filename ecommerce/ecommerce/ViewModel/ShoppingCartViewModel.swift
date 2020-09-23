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
    
    func emptyCart() {
        products.removeAll()
    }
}
