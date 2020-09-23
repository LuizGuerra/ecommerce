//
//  NetworkViewModel.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 22/09/20.
//

import SwiftUI

class DataManagerViewModel: ObservableObject {
  
    @Published var productList: [Product]
    @Published var users: [Client]
    
    init() {
        productList = [
            Product(name: "MacBook Air 13''", price: 999.00, ammount: 15),
            Product(name: "iPad Pro", price: 799.00, ammount: 30),
            Product(name: "Watch SE", price: 279, ammount: 30),
            
            Product(name: "Mi 10 Lite", price: 499.00, ammount: 30),
            Product(name: "Mi LED TV 4A 32''", price: 399.00, ammount: 20),
            Product(name: "Mi Smart Band 5", price: 44.99, ammount: 2),
            Product(name: "Mi Earphones 2", price: 59.99, ammount: 1)
        ]
        users = [
            Client(name: "Luiz Guerra", userName: "LuizGuerra", password: "123456", cpf: "111.111.111-11", address: "Rua Ramiro Barcelos-193-Centro-POA-RS-BR"),
            Client(name: "Alberto Rocha", userName: "Alberto", password: "qwerty", cpf: "222.222.222-22", address: "Rua Fernando Miguel-345-Centro-POA-RS-BR"),
        ]
    }
    
    func storageWithItems() -> [Product] {
        var list = [Product]()
        for e in productList {
            if e.ammount > 0 {
                list.append(e)
            }
        }
        return list
    }
    
    func newProduct(product: Product) {
        if let index = productList.firstIndex(where: { $0.name == product.name }) {
            productList[index].ammount += product.ammount > 0 ? product.ammount : 0
        } else {
            productList.append(product)
        }
    }
    
    func newUser(user: Client) {
        if let _ = users.firstIndex(where: { $0.cpf == user.cpf }) {
            return
        }
        users.append(user)
    }
    
}
