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
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Spacer()
            }

            Text(self.title.uppercased())
                .font(.footnote)
                .foregroundColor(Color.gray)

            Text(String(self.amount))
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
