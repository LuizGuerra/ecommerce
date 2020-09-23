//
//  AdminStorage.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 18/09/20.
//

import SwiftUI

struct AdminStorage: View {
    
    @ObservedObject var data: DataManagerViewModel
    @State private var addItemView = false
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Form {
                        Section {
                            List {
                                ForEach (data.productList, id: \.id) { item in
                                    BuyCard(product: item)
                                }.onDelete(perform: { indexSet in
                                    data.productList.remove(atOffsets: indexSet)
                                })
                            }
                        }
                    }
                }.navigationTitle("Storage")
                .navigationBarItems(trailing:
                    Button(action: {
                        addItemView.toggle()
                    }, label: {
                        Image(systemName: "plus")
                            .padding()
                    })
                )
            }
        }
        .sheet(isPresented: $addItemView, content: {
            AddItem(isAddingItem: $addItemView, data: data)
        })
    }
}

struct AdminStorage_Previews: PreviewProvider {
    static var previews: some View {
        AdminStorage(data: DataManagerViewModel())
    }
}
