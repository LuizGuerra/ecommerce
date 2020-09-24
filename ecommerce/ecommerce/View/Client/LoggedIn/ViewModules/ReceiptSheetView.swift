//
//  ReceiptSheetView.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 23/09/20.
//

import SwiftUI

struct ReceiptSheetView: View {
    var cart: ShoppingCart
    @Binding var receiptSheet: Bool
    @Binding var finalizeBuySheet: Bool
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Item")
                            .padding(.bottom, 0.5)
                        ForEach(cart.products, id: \.id) { item in
                            HStack {
                                Text(item.name)
                                    .fontWeight(.thin)
                            }
                        }
                    }
                    Spacer()
                    VStack(alignment: .trailing) {
                        Text("Price")
                            .padding(.bottom, 0.5)
                        ForEach(cart.products, id: \.id) { item in
                            HStack {
                                Text(String(format: "%.2f", item.price))
                                    .fontWeight(.thin)
                            }
                        }
                    }
                    VStack(alignment: .trailing) {
                        Text("Total")
                            .padding(.bottom, 0.5)
                        ForEach(cart.products, id: \.id) { item in
                            HStack {
                                Text(String(item.ammount))
                                    .fontWeight(.thin)
                            }
                        }
                    }
                }.padding()
                .font(Font.custom("Menlo", size: 16.0))
                Button(action: {
                    exitScreen()
                }, label: {
                    Text("Save").padding(8)
                })
                Button(action: {
                    exitScreen()
                }, label: {
                    Text("Exit")
                        .padding(8)
                        .accentColor(.red)
                })
            }.navigationTitle("Receipt")
        }
    }
    
    private func exitScreen() {
        cart.products.removeAll()
        receiptSheet.toggle()
        finalizeBuySheet.toggle()
    }
    
}

struct ReceiptSheetView_Previews: PreviewProvider {
    @State private static var one = true
    @State private static var two = true
    static var previews: some View {
        let cart = ShoppingCart()
        cart.products.append(contentsOf:  DataManagerViewModel().productList)
        return ReceiptSheetView(cart: cart, receiptSheet: $one, finalizeBuySheet: $two)
    }
}
