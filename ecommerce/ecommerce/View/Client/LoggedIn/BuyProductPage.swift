//
//  BuyProductSheet.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 22/09/20.
//

import SwiftUI

struct BuyProductPage: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var ammount = ""
    var cart: ShoppingCart
    var product: Product
    var body: some View {
        VStack {
            VStack {
                Form {
                    Section {
                        HStack(alignment: .center) {
                            Spacer()
                            VStack {
                                Text(String(format: "$ %.2f", product.price))
                                    .font(.largeTitle)
                                    .foregroundColor(Color(hue: 0.344, saturation: 1.0, brightness: 0.662))
                                Text("Only \(product.ammount) units left!")
                                    .font(.headline)
                                    .fontWeight(.light)
                            }
                            Spacer()
                        }.padding()
                    }
                    Section {
                        TextField("Select an ammount", text: $ammount)
                            .keyboardType(.decimalPad)
                            .onChange(of: ammount, perform: { value in
                                if (Int(ammount) ?? 0) > product.ammount {
                                    ammount = "\(product.ammount)"
                                }
                            })
                        Text("Total: " + getTotal())
                    }
                    Section {
                        Button(action: {
                            if let units = Int(ammount) ?? 0, units > 0 {
                                cart.placeOrder(product: Product(name: product.name, price: product.price, ammount: units), maxOrders: product.ammount)
                            }
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Set order")
                                Spacer()
                            }
                        })
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                            HStack {
                                Spacer()
                                Text("Cancel")
                                    .accentColor(.red)
                                Spacer()
                            }
                        })
                    }
                }
                .navigationTitle(product.name)
                .navigationViewStyle(StackNavigationViewStyle())
            }
        }
    }
    
    private func getTotal() -> String {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        if ammount.isEmpty {
            return "0.00"
        }
        if let value = Float(ammount) {
            return formatter.string(from: (value*product.price) as NSNumber) ?? "Error calculating price!"
        }
        return "Error calculating price!"
    }
    
}

struct BuyProductPage_Previews: PreviewProvider {
    static var previews: some View {
        BuyProductPage(cart: ShoppingCart(), product: DataManagerViewModel().productList[0])
    }
}

extension String {
    mutating func getPrice(){
        if self.isEmpty {
            self = "$ 0.00"
        }
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        if let number = (Float(self) as NSNumber?) {
            self = formatter.string(from: number) ?? self
        }
    }
}
