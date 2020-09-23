//
//  BuyPage.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 18/09/20.
//

import SwiftUI

struct BuyPage: View {
    @Binding var isLoggedIn: Bool
    @State var buyPage: Bool = false
    @State private var buyButtonColor: Color = Color.red
    
    @State private var buyProductSheet = false
    
    var client: Client
    @ObservedObject var data: DataManagerViewModel
    @ObservedObject var shoppingCart = ShoppingCart()
    
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    Form {
                        Section {
                            List(data.productList, id: \.id) { product in
                                NavigationLink(destination: BuyProductPage(cart: shoppingCart, product: product)) {
                                    BuyCard(product: product)
                                        .padding()
                                }
                            }
                        }
                    }
                    Section {
                        Button(action: {
                            buyPage.toggle()
                        }, label: {
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
                        })
                    }
                }.navigationBarTitle(client.name.isEmpty ? "Hello!" : "Hello, \(client.name.components(separatedBy: " ")[0])!")
                .navigationBarItems(trailing: Button(action: {
                    isLoggedIn.toggle()
                }, label: {
                    Image("loggout")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .padding()
                }))
            }
        }.sheet(isPresented: $buyPage, content: {
            FinalizeBuyView(shoppingCart: shoppingCart, data: data, finalizeBuySheet: $buyPage)
        })
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

struct BuyPage_Previews: PreviewProvider {
    @State private static var loggedIn = true
    @ObservedObject private static var data = DataManagerViewModel()
    static let client = Client(name: "Luiz Guerra", userName: "LuizGuerra", password: "123456", cpf: "", address: "")
    static var previews: some View {
        viewWithoutItem
    }
    static var viewWithoutItem: some View {
        BuyPage(isLoggedIn: $loggedIn, client: client, data: data)
    }
    static var viewWithItem: some View {
        let view = BuyPage(isLoggedIn: $loggedIn, client: client, data: data)
        var product = data.productList[0]
        product.ammount = 1
        view.shoppingCart.products.append(product)
        return view
    }
}
