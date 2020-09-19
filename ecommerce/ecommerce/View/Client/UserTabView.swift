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
                BuyPage(isLoggedIn: $isLoggedIn)
            } else {
                LoginPage(isLoggedIn: $isLoggedIn)
//                BuyPage()
            }
        }
    }
}

struct UserTabView_Previews: PreviewProvider {
    @State static var isLoggedIn: Bool = false
    static var previews: some View {
        UserTabView(isLoggedIn: $isLoggedIn)
    }
}
