//
//  SwiftUIView.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 24/11/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import SwiftUI

struct LendAndBorrowView: View {

    @ObservedObject var lnbVM = LendAndBorrowViewModel()

    @State var showAddSheet = false

    var addButton: some View {
        Button(action: { self.showAddSheet.toggle() }) {
            Image(systemName: "plus")
                .imageScale(.small)
                .accessibility(label: Text("Add New"))
                .padding()
        }
    }

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading) {
                    HStack(alignment: .top, spacing: 10) {
                        SummaryView(
                            type: "lent",
                            amount: lnbVM.totalLent,
                            time: "3 hours ago",
                            color: "success")

                        SummaryView(
                            type: "borrowed",
                            amount: lnbVM.totalBorrowed,
                            time: "3 months ago",
                            color: "danger")
                    }

                    VStack(alignment: .center, spacing: 10) {
                        ForEach(lnbVM.contacts, id: \.id) { contact in
                            NavigationLink(destination: ContactDetailsView()) {
                                ContactRowView(contact: contact)
                                    .font(.body)
                                    .padding()
                                    .background(Color("rowsBg"))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color("itemBorder").opacity(0.2), lineWidth: 1))
                            }
                        }
                    }
                    .padding(.top, 10)
                }
                .padding(10)
                .background(Color("sceneBg"))
            }
            .navigationBarTitle(Text("Lend & Borrow"))
            .navigationBarItems(trailing: addButton)
            .sheet(isPresented: $showAddSheet) {
                AddNewView()
            }
        }
    }
}

struct SummaryView: View {
    let type: String
    let amount: Int
    let time: String
    let color: String

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Spacer()
            }

            Text(String(self.amount))
            Text(self.type)
            Text(self.time)
        }
        .font(.body)
        .foregroundColor(Color(color))
        .padding()
        .background(Color(color).opacity(0.1))
        .cornerRadius(10)
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
