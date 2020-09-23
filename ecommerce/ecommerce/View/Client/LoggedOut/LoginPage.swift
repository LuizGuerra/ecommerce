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
    @State private var signupScreen = false
    
    @Binding var isLoggedIn: Bool
    
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
                    SecureField("Password", text: $password)
                        .textContentType(.password)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(4)
                }
                .padding()
                VStack {
                    Button(action: {
                        if login.count > 3 && password.count > 3 {
                            isLoggedIn.toggle()
                        }
                    }, label: {
                        Text("Login")
                            .accentColor(Color.white)
                            .padding(.horizontal, 64)
                            .padding(.vertical, 16)
                            .background(Color.black)
                            .cornerRadius(4)
                    })
                    Button(action: {
                        signupScreen.toggle()
                    }, label: {
                        Text("Signup")
                            .padding()
                    })
                }
            }
        }
        .sheet(item: $signupScreen, content: {
            Text("Hewwo")
        })
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
    static var previews: some View {
        LoginPage(isLoggedIn: $isLoggedIn)
    }
}
