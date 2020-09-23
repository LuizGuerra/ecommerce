//
//  SignUp.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 22/09/20.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var name: String = ""
    @State private var userName: String = ""
    @State private var password = ""
    
    @State private var cpf: String = ""
    
    @State private var addressStreet = ""
    @State private var addressNumber = ""
    @State private var addressCity = ""
    @State private var addressDistrict = ""
    @State private var addressCountry = ""
    
    var data: DataManagerViewModel
    @Binding var signupView: Bool
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    Form {
                        Section(header: Text("Full name").bold()) {
                            TextField("Example: Riley Smith", text: $name)
                        }
                        Section(header: Text("Login Information").bold()) {
                            TextField("Username", text: $userName)
                            SecureField("Password", text: $password)
                        }
                        Section(header: Text("CPF").bold()) {
                            TextField("000.000.000-00", text: $cpf)
                                .keyboardType(.decimalPad)
                        }
                        Section(header: Text("Address").bold()) {
                            TextField("Street name", text: $addressStreet)
                            TextField("House/building number", text: $addressNumber)
                            TextField("City", text: $addressCity)
                            TextField("District", text: $addressDistrict)
                            TextField("Country", text: $addressCountry)
                        }
                        Section() {
                            Button(action: {
                                connect()
                            }, label: {
                                HStack {
                                    Spacer()
                                    Text("Create account")
                                    Spacer()
                                }
                            })
                            Button(action: {
                                signupView.toggle()
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
                .navigationTitle("SingUp")
            }
        }
    }
    
    private func allInputIsCorrect() -> Bool {
        return name.count > 5 && password.count > 5 &&
            cpf.count == 11 && addressStreet.count > 3 &&
            !addressNumber.isEmpty && !addressCity.isEmpty &&
            !addressDistrict.isEmpty && !addressCountry.isEmpty
    }
    
    private func formatAddress() -> String {
        return "\(addressStreet)-\(addressNumber)-\(addressCity)-\(addressDistrict)-\(addressCountry)"
    }
    
    private func connect() {
        if allInputIsCorrect() {
            data.newUser(user: Client(name: name, userName: userName, password: password, cpf: cpf, address: formatAddress()))
            signupView.toggle()
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    @State static private var signupView = true
    @State static private var isLoggedIn = false
    @State static private var userCPF = ""
    static var previews: some View {
        SignUpView(data: DataManagerViewModel(), signupView: $signupView)
    }
}
