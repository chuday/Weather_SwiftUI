//
//  LoginPasswordView.swift
//  Swift_UI
//
//  Created by Mikhail Chudaev on 10.12.2021.
//

import SwiftUI

struct LoginPasswordView: View {
    
    @Binding var login: String
    @Binding var password: String
    
    var body: some View {
        
        VStack {
            HStack {
                Text("Login")
                Spacer()
                TextField("Login", text: $login)
                    .frame(maxWidth: 150)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack {
                Text("Password")
                Spacer()
                SecureField("Password", text: $password)
                    .frame(maxWidth: 150)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
        }
        .frame(maxWidth: 250)
    }
}
