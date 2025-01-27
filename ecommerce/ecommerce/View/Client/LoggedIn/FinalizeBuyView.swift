//
//  FinalizeBuyView.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 22/09/20.
//

import SwiftUI

struct FinalizeBuyView: View {
    @ObservedObject var shoppingCart: ShoppingCart
    var data: DataManagerViewModel
    
    @Binding var finalizeBuySheet: Bool
    @State private var receipt = false
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Form {
                        Section {
                            List {
                                ForEach(shoppingCart.products, id: \.id) { product in
                                    HStack {
                                        BuyCard(product: product)
                                        Spacer()
                                        Text(String(product.ammount))
                                            .font(.largeTitle)
                                            .fontWeight(.light)
                                    }
                                }
                                .onDelete(perform: { indexSet in
                                    shoppingCart.products.remove(atOffsets: indexSet)
                                })
                            }
                        }
                    }
                    Section {
                        Button(action: {
                            finalizeBuy()
                            receipt.toggle()
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Finalize buy")
                                    .fontWeight(.bold)
                                    .padding(.vertical)
                                    .accentColor(.white)
                                Spacer()
                            }
                            .background(Color.green)
                        })
                    }
                }.navigationTitle("Total: " + getPrice())
            }
        }
        .sheet(isPresented: $receipt, content: {
            ReceiptSheetView(cart: shoppingCart, receiptSheet: $receipt, finalizeBuySheet: $finalizeBuySheet)
        })
    }
    
    private func finalizeBuy() {
        for item in shoppingCart.products {
            for index in 0 ..< data.productList.count {
                if item.name == data.productList[index].name {
                    data.productList[index].ammount -= item.ammount
                    break
                }
            }
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

struct FinalizeBuyView_Previews: PreviewProvider {
    @State static private var isShowing = true
    static var previews: some View {
        let cart = ShoppingCart()
        let data = DataManagerViewModel()
        cart.products.append(data.productList[0])
        cart.products.append(data.productList[1])
        cart.products.append(data.productList[2])
        return FinalizeBuyView(shoppingCart: cart, data: data, finalizeBuySheet: $isShowing)
    }
}
