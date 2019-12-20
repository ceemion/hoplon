//
//  CreateAccountView.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 16/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import SwiftUI

struct CreateAccountView: View {

    @EnvironmentObject var userAccount: UserAccount

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("""
                Let's create
                your account
                """)

            VStack(alignment: .leading, spacing: 5) {
                Label(text: "Full Name")
                TextField("", text: $userAccount.newFullName)
                    .textFieldStyle(HoplonTextFieldStyle())
                    .autocapitalization(.words)
            }

            VStack(alignment: .leading, spacing: 5) {
                Label(text: "Email")
                TextField("", text: $userAccount.newEmail)
                    .textFieldStyle(HoplonTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }

            VStack(alignment: .leading, spacing: 5) {
                Label(text: "Password")
                SecureField("", text: $userAccount.newPassword)
                    .textFieldStyle(HoplonTextFieldStyle())
            }

            Button(action: { self.userAccount.createAccount() }) {
                if self.userAccount.loading {
                    Text("Please wait...")
                } else {
                    Text("Create Account")
                }
            }
            Spacer()
        }
        .padding()
    }
}

struct CreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        CreateAccountView()
    }
}
