//
//  User.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 18/09/20.
//

import SwiftUI

struct UserTabView: View {
    @Binding var isLoggedIn: Bool
    var body: some View {
        ZStack {
            if isLoggedIn {
                BuyPage()
            }
            if !isLoggedIn {
                LoginPage(isLoggedIn: $isLoggedIn)
            }
        }
    }
}
