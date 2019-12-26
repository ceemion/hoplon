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
        VStack(alignment: .leading, spacing: 16) {
            Text("""
                Let's create
                your account
                """)
                .font(Font.custom(Constants.Font.titleMed, size: 25))
                .foregroundColor(Color("text"))

            Text(userAccount.error.error)
                .font(.footnote)
                .foregroundColor(Color("danger"))

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
                HStack {
                    Spacer()
                    Text("\(self.userAccount.loading ? "Please wait..." : "Create Account")")
                        .tracking(1.0)
                    Spacer()
                }
                .font(Font.custom(Constants.Font.title, size: 16))
                .foregroundColor(Color("primary"))
                .padding()
                .background(Color("primary").opacity(0.2))
                .cornerRadius(10)
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
