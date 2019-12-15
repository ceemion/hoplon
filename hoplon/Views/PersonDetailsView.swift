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

    @State var openNew: Bool = false

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
                VStack(alignment: .center) {
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

                    VStack(alignment: .center, spacing: 10) {
                        if person.data.isEmpty {
                            VStack(spacing: 10) {
                                Text("No transactions here yet.")
                                Text("Lent or Borrowed? Tap the plus icon up top to add a new entry.")
                            }
                            .font(.footnote)
                            .foregroundColor(Color.gray)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.center)
                            .padding()
                        } else {
                            ForEach(person.data) { lb in
                                LBRowView(lb: lb)
                                    .font(.body)
                            }
                        }
                    }
                    .padding(.top, 10)
                }
                .padding(10)
                .background(Color("sceneBg"))
            }
        }
        .navigationBarTitle(Text("\(person.first_name) \(person.last_name)"), displayMode: .inline)
        .navigationBarItems(trailing: NewEntryButton(openNew: $openNew))
        .sheet(isPresented: $openNew) {
            NewLendBorrow()
                .environmentObject(LendAndBorrowViewModel(person: self.person))
        }
    }
}

struct NewEntryButton: View {
    @Binding var openNew: Bool

    var body: some View {
        Button(action: { self.openNew.toggle() }) {
            Image(systemName: "plus")
                .imageScale(.small)
                .accessibility(label: Text("New LendBorrow"))
                .padding()
        }
    }
}

struct LBRowView: View {
    var lb: LendBorrow

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack {
                Text(String(lb.amount))
                Spacer()
                Button(action: { print("info btn tapped") }) {
                    Image(systemName: "info.circle")
                        .imageScale(.large)
                        .accessibility(label: Text("Info"))
                }
            }

            Text("Date Due: \(lb.date_due.isEmpty ? "Not Stated" : lb.date_due)")
            Text(lb.notes)
            Text(lb.updated_at)
        }
        .padding()
        .background(lb.lb_type == "lent" ? Color("success").opacity(0.1) : Color("danger").opacity(0.1))
        .cornerRadius(10)
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
