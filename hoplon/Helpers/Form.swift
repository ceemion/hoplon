//
//  Form.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 10/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import Foundation
import SwiftUI

struct Label: View {
    let text: String

    var body: some View {
        Text(text.uppercased())
            .font(Font.custom(Constants.Font.main, size: 10))
            .foregroundColor(Color("gray"))
            .tracking(0.5)
    }
}

public struct HoplonTextFieldStyle : TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(Font.custom(Constants.Font.main, size: 14))
            .foregroundColor(Color("text"))
            .padding()
            .background(Color("inputBg"))
            .cornerRadius(10)
    }
}
