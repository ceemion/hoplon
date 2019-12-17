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

    @Published var loginEmail: String = "f-001@f.com"
    @Published var loginPass: String = "password"

    init() {
        let retrievedJWT: String = KeychainWrapper.standard.string(forKey: "userJWToken") ?? ""

        self.authenticated = retrievedJWT.isEmpty ? false : true
        self.jwt = retrievedJWT
    }

    func login() {
        HttpService().loginUser(self.loginEmail, self.loginPass) { (user, jwt) in
            let jwt = jwt as! String
            let saveToken: Bool = KeychainWrapper.standard.set(jwt, forKey: "userJWToken")
            let saveId: Bool = KeychainWrapper.standard.set(String(user.id), forKey: "userId")

            self.authenticated = saveToken && saveId ? true : false
        }
    }

    func logout() {
        HttpService().logout { (status) in
            if status < 300 {
                let removedToken: Bool = KeychainWrapper.standard.removeObject(forKey: "userJWToken")
                let removedId: Bool = KeychainWrapper.standard.removeObject(forKey: "userId")

                self.authenticated = removedToken && removedId ? false : true
            }
        }
    }
}
