//
//  UserAccount.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 16/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import Foundation

final class UserAccount: ObservableObject {

    @Published var authenticated: Bool = false

    @Published var loginEmail: String = ""
    @Published var loginPass: String = ""

    init() {
//        self.authenticated = true
    }
}
