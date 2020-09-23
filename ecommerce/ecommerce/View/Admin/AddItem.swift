//
//  AddItem.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 18/09/20.
//

import SwiftUI

struct AddItem: View {
    @State private var itemName: String = ""
    @State private var ammount: String = ""
    @State private var price: String = ""
    @Binding var isAddingItem: Bool
    
    var data: DataManagerViewModel
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Form {
                        Section {
                            TextField("Item Name", text: $itemName)
                            TextField("Ammount", text: $ammount)
                                .keyboardType(.numberPad)
                            TextField("Price", text: $price)
                                .keyboardType(.decimalPad)
                        }
                        Section {
                            Button(action: {
                                if isDataRight() {
                                    addItem()
                                }
                                isAddingItem.toggle()
                            }, label: {
                                HStack {
                                    Spacer()
                                    Text("Add Item")
                                    Spacer()
                                }
                            })
                            Button(action: {
                                isAddingItem.toggle()
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
                }
            }
        }
    }
    
    private func isDataRight() -> Bool {
        return !itemName.isEmpty && (Int(ammount) ?? 0) > 0 && (Float(price) ?? 0) > 0
    }
    
    private func addItem() {
        guard let price = Float(ammount), let ammount = Int(ammount) else { return }
        data.productList.insert(Product(name: itemName, price: price, ammount: ammount), at: 0)
        print("Item added")
    }
}

struct AddItem_Previews: PreviewProvider {
    @State private static var isAddingItem = true
    static var previews: some View {
        AddItem(isAddingItem: $isAddingItem, data: DataManagerViewModel())
    }
}
