//
//  PistaFunctions.swift
//  pista
//
//  Created by Fiyinfoluwa Adebayo on 11/01/2020.
//  Copyright © 2020 Kompilab Limited. All rights reserved.
//

import Foundation
import UIKit

class PistaFunctions {
    func phoneCallAction(_ n: String) {
        if let number = URL(string: "tel://\(n)") {
            if UIApplication.shared.canOpenURL(number) {
                UIApplication.shared.open(number, options: [:], completionHandler: nil)
            }
        }
    }

    func openUrl(_ u: String) {
        if let url = URL(string: u) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:])
            }
        }
    }
}
