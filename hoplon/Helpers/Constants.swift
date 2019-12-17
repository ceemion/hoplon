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
        static let mainItalic = "Helvetica-Oblique"
    }

    struct TextSizes {
        static let title = 18.0
        static let body = 16.0
    }

    struct Http {
        static let isLive = false
        static let BASE_URL = isLive ? "https://my-forecast-api.herokuapp.com/api" : "http://localhost:5001/api"
        static let BASE_URL_V1 = "\(BASE_URL)/v1"
    }
}
