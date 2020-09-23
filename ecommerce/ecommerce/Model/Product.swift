//
//  Product.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 22/09/20.
//

import Foundation

struct Product {
    var id: UUID
    var name: String
    var price: Float
    var ammount: Int
    
    init(name: String, price: Float, ammount total: Int) {
        self.id = UUID()
        self.name = name
        self.price = price
        self.ammount = total
    }
    
}
