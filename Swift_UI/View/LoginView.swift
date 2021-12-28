//
//  LoginView1.swift
//  Swift_UI
//
//  Created by Mikhail Chudaev on 26.12.2021.
//

import SwiftUI
import WebKit
import Combine

struct LoginView: View {
    
    @State private var login: String = "A"
    @State private var password: String = "1"
    @State private var shouldShowLogo: Bool = true
    
    @State private var showIncorrectCredentialsAlert: Bool = false
    @Binding var showCitiesView: Bool
    
    private let keyboardIsOnPublisher = Publishers.Merge(
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
            .map { _ in true },
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .map { _ in false }
    )
        .removeDuplicates()
    
    var body: some View {
        
        ZStack {
            GeometryReader { geometry in
                Image("sun")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
            
            ScrollView {
                
                VStack {
                    if shouldShowLogo {
                        Text("Weather App")
                            .padding(.top, 32)
                            .font(.largeTitle)
                    }
                    
                    VStack {
                        
                        HStack {
                            Text("Login")
                            Spacer()
                            TextField("Enter login", text: $login)
                                .frame(maxWidth: 150)
                                .keyboardType(.emailAddress)
                                .autocapitalization(.none)
                        }
                        
                        HStack {
                            Text("Password")
                            Spacer()
                            SecureField("Enter password", text: $password)
                                .frame(maxWidth: 150)
                        }
                    }
                    .frame(maxWidth: 250)
                    
                    Button(action: self.onLoginPressed) {
                        
                        HStack {
                            Text("Log in")
                            Image(systemName: "arrow.up")
                        }
                    }
                    .padding(EdgeInsets(top: 50, leading: 0, bottom: 20, trailing: 0))
                    .disabled(login.isEmpty || password.isEmpty)
                    
                    Spacer()
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .onReceive(keyboardIsOnPublisher) { value in
            withAnimation {
                self.shouldShowLogo = !value
            }
        }
        .onTapGesture {
            self.endEditing()
        }
        
        .alert(isPresented: $showIncorrectCredentialsAlert) {
            Alert(title: Text("Warning"),
                  message: Text("Incorrect password or login, try again!"),
                  dismissButton: .cancel()
            )
        }
        .navigationBarHidden(true)
    }
    
    private func onLoginPressed() {
        if login == "A" && password == "1" {
            self.showCitiesView = true
        } else {
            self.showIncorrectCredentialsAlert = true
        }
    }
    
    private func endEditing() {
        UIApplication.shared.endEditing()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            LoginView(showCitiesView: .constant(false))
                .previewDevice(PreviewDevice.init(rawValue: "iPhone 12"))
        }
    }
}
