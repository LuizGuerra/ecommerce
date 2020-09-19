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
    @Binding var isAddingItem: Bool
    
    var storage: Storage
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Form {
                        Section {
                            TextField("Item Name", text: $itemName)
                            TextField("Ammount", text: $ammount)
                                .keyboardType(.decimalPad)
                        }
                        Section {
                            Button(action: {
                                if itemName.count > 0 {
                                    storage.items.append(itemName)
                                    isAddingItem.toggle()
                                }
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
}

struct AddItem_Previews: PreviewProvider {
    @State private static var isAddingItem = true
    static var previews: some View {
        AddItem(isAddingItem: $isAddingItem, storage: Storage())
    }
}
