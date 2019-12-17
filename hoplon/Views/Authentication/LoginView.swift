//
//  LoginView.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 16/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import SwiftUI

struct LoginView: View {

    @EnvironmentObject var userAccount: UserAccount

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Group {
                Text("Welcome back.")
                Text("Great to see you again")
            }

            VStack(alignment: .leading, spacing: 5) {
                Label(text: "Email")
                TextField("", text: $userAccount.loginEmail)
                    .textFieldStyle(HoplonTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }

            VStack(alignment: .leading, spacing: 5) {
                Label(text: "Password")
                SecureField("", text: $userAccount.loginPass)
                    .textFieldStyle(HoplonTextFieldStyle())
            }

            Button(action: { self.userAccount.login() }) {
                Text("Log in")
            }
            Spacer()
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
