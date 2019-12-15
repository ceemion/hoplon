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
