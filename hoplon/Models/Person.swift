//
//  Contact.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 04/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import Foundation

struct Person: Identifiable, Codable {
    let id: Int
    let user_id: Int
    let first_name: String
    let last_name: String
    let email: String
    let phone_number: String
    let total_lent: Double
    let total_borrowed: Double
    let data: [LendBorrow]
}

struct PersonPayload: Codable {
    let first_name: String
    let last_name: String
    let email: String
    let phone_number: String
}
