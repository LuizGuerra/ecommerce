//
//  BuyButtonView.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 23/09/20.
//

import SwiftUI

struct BuyButtonView: View {
    @ObservedObject var shoppingCart: ShoppingCart
    var body: some View {
        VStack {
            if shoppingCart.products.count > 0 {
                HStack {
                    Image("shopping-cart")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .accentColor(.blue)
                    Text("Total: " + getPrice())
                        .padding(8)
                        .accentColor(.black)
                }
            }
            HStack {
                Spacer()
                Text("Buy")
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .accentColor(.white)
                Spacer()
            }.background(
                shoppingCart.products.count == 0 ? Color.red : Color.green
            )
        }
    }
    
    private func getPrice() -> String {
        let total = shoppingCart.getTotal()
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        return formatter.string(from: total as NSNumber) ?? "Could not calculate"
    }
}

struct BuyButtonView_Previews: PreviewProvider {
    static var previews: some View {
        let cart = ShoppingCart()
        cart.products.append(DataManagerViewModel().productList[0])
        return BuyButtonView(shoppingCart: cart)
    }
}
