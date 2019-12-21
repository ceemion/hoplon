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
        VStack(alignment: .leading, spacing: 16) {
            Text("""
                Welcome back.
                Great to see you again
                """)
                .font(Font.custom(Constants.Font.titleMed, size: 25))
                .foregroundColor(Color("text"))

            Text(userAccount.error.error)
                .font(.footnote)
                .foregroundColor(Color("danger"))

            VStack(alignment: .leading, spacing: 5) {
                Label(text: "Email")
                TextField("", text: $userAccount.loginEmail)
                    .textFieldStyle(HoplonTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
            }

            VStack(alignment: .leading, spacing: 5) {
                Label(text: "Password")
                SecureField("", text: $userAccount.loginPassword)
                    .textFieldStyle(HoplonTextFieldStyle())
            }

            Button(action: { self.userAccount.login() }) {
                HStack {
                    Spacer()
                    Text("\(self.userAccount.loading ? "Please wait..." : "Login")")
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
