//
//  Constants.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 05/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import Foundation

struct Constants {

    struct Font {
        static let title = "NewYorkSmall-Regular"
        static let nav = "NewYorkSmall-Semibold"
        static let main = "Helvetica"
    }

    struct TextSizes {
        static let body = 16.0
    }

    struct Http {
        static let isLive = false
        static let BASE_URL = isLive ? "https://my-forecast-api.herokuapp.com/api/v1" : "http://localhost:5001/api/v1"
    }
}
