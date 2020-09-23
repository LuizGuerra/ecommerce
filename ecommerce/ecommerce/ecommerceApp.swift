//
//  ecommerceApp.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 18/09/20.
//

import SwiftUI

@main
struct ecommerceApp: App {
    private var data: DataManagerViewModel = DataManagerViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(data: data)
        }
    }
}
