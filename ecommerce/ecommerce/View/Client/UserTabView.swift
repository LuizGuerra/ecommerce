//
//  User.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 18/09/20.
//

import SwiftUI

struct UserTabView: View {
    @ObservedObject var data: DataManagerViewModel
    @State private var loggedUserCPF = ""
    @State var isLoggedIn: Bool = false
    var body: some View {
        ZStack {
            if isLoggedIn {
                BuyPage(isLoggedIn: $isLoggedIn, client: data.users.first(where: { $0.cpf == loggedUserCPF}) ?? Client(name: "", userName: "", password: "", cpf: "", address: ""), data: data)
            } else {
                LoginPage(data: data, isLoggedIn: $isLoggedIn, userCPF: $loggedUserCPF)
            }
        }
    }
}

struct UserTabView_Previews: PreviewProvider {
    static var previews: some View {
        UserTabView(data: DataManagerViewModel())
    }
}
