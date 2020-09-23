//
//  ContentView.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 18/09/20.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var data: DataManagerViewModel
    var body: some View {
        TabView {
            UserTabView(data: data)
                .tabItem {
                    Image(systemName: "person")
                    Text("Client")
                }
            AdminStorage(data: data)
                .tabItem {
                    Image(systemName: "cloud")
                    Text("Admin")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(data: DataManagerViewModel())
    }
}
