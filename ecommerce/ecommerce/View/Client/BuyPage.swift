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
    @State var itemsInCart: Bool = false
    @State private var buyButtonColor: Color = Color.red
    var body: some View {
        VStack {
            NavigationView {
                VStack {
                    Form {
                        Section {
                            Text("Here we will show you the items to add!")
                                .padding()
                        }
                    }
                }.navigationBarTitle("Hello, user!")
                .navigationBarItems(trailing: Button(action: {
                    isLoggedIn.toggle()
                }, label: {
                    Image("loggout")
                        .resizable()
                        .frame(width: 22, height: 22)
                        .padding()
                }))
            }
            Button(action: {
                itemsInCart.toggle()
                withAnimation {
                    buyButtonColor = itemsInCart ? .green : .red
                }
            }, label: {
                HStack {
                    Spacer()
                    Text("Buy")
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .accentColor(.white)
                    Spacer()
                }
                .background(buyButtonColor)
            })
        }
    }
}

struct BuyPage_Previews: PreviewProvider {
    @State private static var loggedIn = true
    static var previews: some View {
        BuyPage(isLoggedIn: $loggedIn)
    }
}
