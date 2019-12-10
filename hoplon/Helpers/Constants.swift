//
//  Constants.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 05/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import Foundation

struct Constants {

    struct Http {
        static let isLive = false
        static let BASE_URL = isLive ? "https://my-forecast-api.herokuapp.com/api/v1" : "http://localhost:5001/api/v1"
    }
}
