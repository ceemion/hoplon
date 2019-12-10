//
//  Aggregator.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 05/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import Foundation

struct Aggregator: Codable {
    let total_lent: Int
    let total_borrowed: Int
    let contacts: [Person]
}
