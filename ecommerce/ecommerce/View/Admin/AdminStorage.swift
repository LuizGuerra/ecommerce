//
//  AdminStorage.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 18/09/20.
//

import SwiftUI

class Storage: ObservableObject {
    @Published var items: [String] = [
        "Apple",
        "Banana",
        "Orange"
    ]
    init() {}
}

struct AdminStorage: View {
    
    @ObservedObject var storage = Storage()
    @State private var addItemView = false
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Form {
                        Section {
                            List {
                                ForEach (storage.items, id: \.self) { section in
                                    Text(section)
                                }.onDelete(perform: { indexSet in
                                    storage.items.remove(atOffsets: indexSet)
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
            AddItem(isAddingItem: $addItemView, storage: storage)
        })
    }
}

struct AdminStorage_Previews: PreviewProvider {
    static var previews: some View {
        AdminStorage()
    }
}
