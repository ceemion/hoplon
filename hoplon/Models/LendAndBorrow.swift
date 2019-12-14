//
//  LendAndBorrow.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 10/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import Foundation

struct LendBorrow: Codable {
    let id: Int
    let user_id: Int
    let contact_id: Int
    let amount: Double
    let status: String
    let date_due: String
    let date: String
    let deleted: Bool
    let lb_type: String
    let notes: String
    let updated_at: String
}

struct LBPayload: Codable {
    let amount: String
    let contact_id: Int
    let status: String
    let date_due: String
    let date: String
    let lb_type: String
    let notes: String
}
