//
//  SwiftUIView.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 24/11/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import SwiftUI

struct LendAndBorrowView: View {

    @ObservedObject var contactsVM = ContactsViewModel()

    let contacts: [Contact] = [
        .init(id: 1, user_id: 1, first_name: "Simeon", last_name: "Logik", email: "sl@email.com", phone_number: "0812", lendborrow_count: 3),
        .init(id: 2, user_id: 1, first_name: "Jinx", last_name: "King", email: "sl@email.com", phone_number: "0812", lendborrow_count: 0),
        .init(id: 3, user_id: 1, first_name: "Joy", last_name: "Peace", email: "sl@email.com", phone_number: "0812", lendborrow_count: 34),
        .init(id: 4, user_id: 1, first_name: "Jt", last_name: "E", email: "sl@email.com", phone_number: "0812", lendborrow_count: 34)
    ]

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    HStack {
                        SummaryView(type: "lent", amount: "230,000k", time: "3 hours ago")
                            .padding()
                            .background(Color("success").opacity(0.15))
                            .cornerRadius(10)
                            .foregroundColor(Color.black)
                        SummaryView(type: "borrowed", amount: "2.3k", time: "3 months ago")
                            .padding()
                            .background(Color("danger").opacity(0.15))
                            .cornerRadius(10)
                            .foregroundColor(Color.black)
                    }

                    VStack(alignment: .center, spacing: 10) {
                        ForEach(contacts) { contact in
                            ContactRowView(contact: contact)
                                .font(.body)
                                .padding()
                                .background(Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color("itemBorder").opacity(0.2), lineWidth: 1))
                        }
                    }
                }
                .padding(10)
                .background(Color("sceneBg"))
            }
            .navigationBarTitle(Text("Lend & Borrow"))
        }
    }
}

struct SummaryView: View {
    let type: String
    let amount: String
    let time: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(self.amount)
            Text(self.type)
            Text(self.time)
        }
        .font(.body)
    }
}

struct ContactRowView: View {
    let contact: Contact

    var body: some View {
        HStack {
            Text("\(contact.first_name) \(contact.last_name)")
            Spacer()
            Text(String(contact.lendborrow_count))
        }
    }
}

struct LendAndBorrowView_Previews: PreviewProvider {
    static var previews: some View {
        LendAndBorrowView()
    }
}
