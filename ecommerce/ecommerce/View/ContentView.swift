//
//  ContentView.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 18/09/20.
//

import SwiftUI

struct ContentView: View {
    @State var isLoggedIn: Bool = false
    var body: some View {
        TabView {
            UserTabView(isLoggedIn: $isLoggedIn)
                .tabItem {
                    Image(systemName: "person")
                    Text("Client")
                }
            AdminStorage()
                .tabItem {
                    Image(systemName: "cloud")
                    Text("Admin")
                }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
