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
            .font(.footnote)
    }
}

public struct HoplonTextFieldStyle : TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.body)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(Color.primary.opacity(0.1), lineWidth: 1))
    }
}
