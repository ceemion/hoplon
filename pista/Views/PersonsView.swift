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

    @State var showAddSheet: Bool = false

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
                if persons.loading {
                    VStack {
                        HStack {
                            Spacer()
                        }

                        Text("Loading...")
                            .font(.footnote)
                            .foregroundColor(Color.gray)
                            .padding()
                    }
                } else {
                    VStack(alignment: .leading) {
                        HStack(alignment: .top, spacing: 10) {
                            SummaryView(
                                title: "lent",
                                amount: persons.totalLent,
                                color: "success")

                            SummaryView(
                                title: "borrowed",
                                amount: persons.totalBorrowed,
                                color: "danger")
                        }

                        VStack(alignment: .center, spacing: 10) {
                            if persons.persons.isEmpty {
                                VStack(spacing: 10) {
                                    Text("No persons here yet.")
                                    Text("Lent or Borrowed? Add a new contact now.")
                                }
                                .font(.footnote)
                                .foregroundColor(Color.gray)
                                .fixedSize(horizontal: false, vertical: true)
                                .multilineTextAlignment(.center)
                                .padding()
                            } else {
                                ForEach(persons.persons, id: \.id) { person in
                                    NavigationLink(destination: PersonDetailsView(person: person)) {
                                        RowView(person: person)
                                            .font(.body)
                                            .padding(.vertical, 20)
                                            .padding(.horizontal, 10)
                                            .background(Color("rowsBg"))
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .stroke(Color("itemBorder").opacity(0.2), lineWidth: 1))
                                    }
                                }
                            }
                        }
                        .padding(.top, 10)
                    }
                    .padding(10)
                    .background(Color("sceneBg"))
                }
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

struct RowView: View {
    let person: Person

    var body: some View {
        HStack {
            Text("\(person.first_name) \(person.last_name)")
                .accentColor(Color("text"))
            Spacer()
            Text(String(person.data.count))
                .accentColor(Color("text").opacity(0.5))
        }
        .font(Font.custom(Constants.Font.main, size: CGFloat(Constants.TextSizes.body)))
    }
}

struct PersonsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonsView()
    }
}
