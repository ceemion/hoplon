//
//  SummaryView.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 15/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import SwiftUI

struct SummaryView: View {
    let title: String
    let amount: Double
//    let time: String
    let color: String

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(self.title.uppercased())
                .font(Font.custom(Constants.Font.title, size: 10))
                .foregroundColor(Color.gray)

            HStack {
                Spacer()
            }

            Text("\u{20A6} \(String(self.amount))")
                .font(Font.custom(Constants.Font.title, size: 25))
                .foregroundColor(Color(color))
        }
        .font(.body)
        .padding()
        .background(Color(color).opacity(0.1))
        .cornerRadius(10)
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(title: "", amount: 0, color: "")
    }
}
