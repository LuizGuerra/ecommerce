//
//  LoginPage.swift
//  ecommerce
//
//  Created by Luiz Pedro Franciscatto Guerra on 18/09/20.
//

import SwiftUI

struct LoginPage: View {
    @State private var login: String = ""
    @State private var password: String = ""
    @State private var wrongInfo = false
    
    @State private var signupScreen = false
    @State private var buttonColor = Color.black
    
    var data: DataManagerViewModel
    @Binding var isLoggedIn: Bool
    @Binding var userCPF: String
    
    var body: some View {
        ZStack {
            AnimatedBackground()
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("mobile-phone")
                    .resizable()
                    .frame(width: 300, height: 300, alignment: .center)
                    .padding(.bottom, 32)
                
                VStack {
                    TextField("Login", text: $login)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .onChange(of: login, perform: { value in
                            if buttonColor == .red {
                                withAnimation{
                                    buttonColor = .black
                                }
                            }
                        })
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                        .onChange(of: login, perform: { value in
                            if buttonColor == .red {
                                withAnimation{
                                    buttonColor = .black
                                }
                            }
                        })
                }
                .padding()
                VStack {
                    Button(action: {
                        connect()
                    }, label: {
                        Text("Login")
                            .accentColor(Color.white)
                            .padding(.horizontal, 64)
                            .padding(.vertical, 16)
                            .background(buttonColor)
                            .cornerRadius(4)
                    })
                    Button(action: {
                        signupScreen.toggle()
                    }, label: {
                        Text("Signup")
                            .padding()
                    })
                }
            }.sheet(isPresented: $signupScreen, content: {
                SignUpView(data: data, signupView: $signupScreen)
            })
            .alert(isPresented: $wrongInfo, content: {
                Alert(title: Text("Invalid login or password"))
            })
        }
    }
    
    private func connect() {
        if login.count > 3 && password.count > 3 {
            if let user = data.users.first(where: { $0.userName == login }) {
                if password == user.password {
                    userCPF = user.cpf
                    isLoggedIn.toggle()
                    return
                }
            }
        }
        wrongInfo.toggle()
        withAnimation{
            buttonColor = .red
        }
    }
}

struct AnimatedBackground: View {
    @State var start = UnitPoint(x: 0, y: -2)
    @State var end = UnitPoint(x: 4, y: 0)
    let timer = Timer.publish(every: 0.3, on: .main, in: .default).autoconnect()
    let colors: [Color] = [.red, .purple, .pink, .yellow, .green, .orange]
    var body: some View {
        LinearGradient(gradient: Gradient(colors: colors), startPoint: start, endPoint: end)
            .animation(Animation.easeInOut(duration: 6).repeatForever())
            .onReceive(timer, perform: { _ in
                self.start = UnitPoint(x: 4, y: 0)
                self.end = UnitPoint(x: 0, y: 2)
                self.start = UnitPoint(x: -4, y: 20)
                self.start = UnitPoint(x: 4, y: 0)
            }).blur(radius: 50, opaque: true)
    }
}

struct LoginPage_Previews: PreviewProvider {
    @State static var isLoggedIn = false
    @State static var userCPF = ""
    static var previews: some View {
        LoginPage(data: DataManagerViewModel(), isLoggedIn: $isLoggedIn, userCPF: $userCPF)
    }
}
