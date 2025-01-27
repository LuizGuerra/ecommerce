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
                            if data.storageIsEmpty() {
                                OutOfStockView()
                            } else {
                                ProductsList(productList: listWithItems(), shoppingCart: shoppingCart)
                            }
                        }
                    }
                    Section {
                        Button(action: {
                            buyPage.toggle()
                        }, label: {
                            BuyButtonView(shoppingCart: shoppingCart)
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
    
    func listWithItems() -> [Product] {
        return data.productList.filter { $0.ammount > 0 }
    }
}

struct BuyPage_Previews: PreviewProvider {
    @State private static var loggedIn = true
    @ObservedObject private static var data = DataManagerViewModel()
    static let client = Client(name: "Luiz Guerra", userName: "LuizGuerra", password: "123456", cpf: "", address: "")
    
    static var previews: some View {
        viewWithoutItem
    }
    
    static var viewWithoutStorage: some View {
        data.productList.removeAll()
        return BuyPage(isLoggedIn: $loggedIn, client: client, data: data)
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
