//
//  User.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 16/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import Foundation

struct User: Identifiable, Codable {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let phone_number: String
}
