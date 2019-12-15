//
//  ContactDetailsView.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 06/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import SwiftUI

struct PersonDetailsView: View {

    var person: Person

    var body: some View {
        VStack {
            HStack {
                Button(action: { print("contact btn tapped") }) {
                    Image(systemName: "phone")
                        .imageScale(.small)
                        .accessibility(label: Text("Call"))
                }
                Spacer()
                Button(action: { print("contact btn tapped") }) {
                    Image(systemName: "text.bubble")
                        .imageScale(.small)
                        .accessibility(label: Text("Text Message"))
                }
                Spacer()
                Button(action: { print("contact btn tapped") }) {
                    Image(systemName: "paperplane")
                        .imageScale(.small)
                        .accessibility(label: Text("Email"))
                }
                Spacer()
                Button(action: { print("contact btn tapped") }) {
                    Image(systemName: "bubble.left.and.bubble.right")
                        .imageScale(.small)
                        .accessibility(label: Text("Whatsapp"))
                }
            }
            .padding(.top, 10)
            .padding(.bottom, 5)
            .padding(.horizontal, 20)

            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    HStack(alignment: .top, spacing: 10) {
                        SummaryView(
                            title: "total lent",
                            amount: person.total_lent,
                            color: "success")

                        SummaryView(
                            title: "total borrowed",
                            amount: person.total_borrowed,
                            color: "danger")
                    }
                }
                .padding(10)
                .background(Color("sceneBg"))
            }
        }
        .navigationBarTitle(Text("\(person.first_name) \(person.last_name)"), displayMode: .inline)
        .navigationBarItems(trailing: NewEntryButton())
    }
}

struct NewEntryButton: View {
//    @Binding var showAddSheet: Bool

    var body: some View {
        Button(action: { print("add btn tapped") }) {
            Image(systemName: "plus")
                .imageScale(.small)
                .accessibility(label: Text("New LendBorrow"))
                .padding()
        }
    }
}

struct PersonDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailsView(
            person: Person.init(
                id: 0,
                user_id: 0,
                first_name: "",
                last_name: "",
                email: "",
                phone_number: "",
                total_lent: 0,
                total_borrowed: 0,
                data: [])
        )
    }
}
