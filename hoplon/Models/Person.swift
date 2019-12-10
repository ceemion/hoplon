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
    let first_name, last_name, email, phone_number: String
    let lendborrow_count: Int
}
