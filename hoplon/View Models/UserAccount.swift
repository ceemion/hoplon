//
//  UserAccount.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 16/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper

final class UserAccount: ObservableObject {

    @Published var authenticated: Bool = false
    @Published var jwt: String = ""

    @Published var loginEmail: String = "f-003@f.com"
    @Published var loginPassword: String = "password$123"

    @Published var newFullName: String = ""
    @Published var newEmail: String = ""
    @Published var newPassword: String = ""

    @Published var redirectToLogin: Bool = false
    @Published var loading: Bool = false
    @Published var error = Error(error: "")

    init() {
        let retrievedJWT: String = KeychainWrapper.standard.string(forKey: "userJWToken") ?? ""

        self.authenticated = retrievedJWT.isEmpty ? false : true
        self.jwt = retrievedJWT
    }

    func login() {
        self.loading = true

        let payload: [String: String] = [
            "email": self.loginEmail,
            "password": self.loginPassword
        ]

        HttpService().auth("login", payload) { (user, error, jwt) in
            self.loading = false
            let jwt = jwt as! String

            if jwt.isEmpty {
                self.error = error
            } else {
                let saveToken: Bool = KeychainWrapper.standard.set(jwt, forKey: "userJWToken")
                let saveId: Bool = KeychainWrapper.standard.set(String(user.id), forKey: "userId")

                self.loginEmail = ""
                self.loginPassword = ""
                self.error = Error(error: "")

                self.authenticated = saveToken && saveId ? true : false
            }
        }
    }

    func createAccount() {
        self.loading = true

        let splitName = self.newFullName.components(separatedBy: " ")

        let payload: [String: String] = [
            "first_name": splitName[0],
            "last_name": splitName.count > 1 ? splitName[1] : "",
            "email": self.newEmail,
            "phone_number": "",
            "password": self.newPassword,
            "password_confirmation": self.newPassword
        ]

        HttpService().auth("register", payload) { (user, error, jwt) in
            self.loading = false

            if user.id > 0 && error.error.isEmpty {
                self.redirectToLogin = true
            } else {
                self.error = error
            }
        }
    }

    func logout() {
        HttpService().logout { (status) in
            if status < 300 {
                let removedToken: Bool = KeychainWrapper.standard.removeObject(forKey: "userJWToken")
                let removedId: Bool = KeychainWrapper.standard.removeObject(forKey: "userId")

                self.authenticated = removedToken && removedId ? false : true
                self.redirectToLogin = false
            }
        }
    }
}
