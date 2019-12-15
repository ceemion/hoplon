//
//  SwiftUIView.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 24/11/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import SwiftUI

struct PersonsView: View {

    @ObservedObject var persons = PersonsViewModel()

    @State var showAddSheet = false

    var refreshButton: some View {
        Button(action: { self.persons.fetch() }) {
            Image(systemName: "arrow.clockwise")
                .imageScale(.small)
                .accessibility(label: Text("Refresh Persons"))
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
                            amount: persons.totalLent,
                            time: "3 hours ago",
                            color: "success")

                        SummaryView(
                            type: "borrowed",
                            amount: persons.totalBorrowed,
                            time: "3 months ago",
                            color: "danger")
                    }

                    VStack(alignment: .center, spacing: 10) {
                        ForEach(persons.persons, id: \.id) { person in
                            NavigationLink(destination: PersonDetailsView(person: person)) {
                                RowView(person: person)
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
            .navigationBarItems(
                leading: refreshButton,
                trailing: AddButton(showAddSheet: $showAddSheet)
            )
        }
        .sheet(isPresented: $showAddSheet) {
            NewPersonView()
                .environmentObject(self.persons)
        }
    }
}

struct AddButton: View {
    @Binding var showAddSheet: Bool

    var body: some View {
        Button(action: { self.showAddSheet.toggle() }) {
            Image(systemName: "person.badge.plus")
                .imageScale(.small)
                .accessibility(label: Text("New Person"))
                .padding()
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

struct RowView: View {
    let person: Person

    var body: some View {
        HStack {
            Text("\(person.first_name) \(person.last_name)")
            Spacer()
            Text(String(person.data.count))
        }
    }
}

struct PersonsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonsView()
    }
}
