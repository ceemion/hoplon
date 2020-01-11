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
    @EnvironmentObject var userAccount: UserAccount

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
                } else if !persons.loading && persons.error.error == "Signature has expired" {
                    Text("Your session has expired")
                        .font(.footnote)
                        .foregroundColor(Color("danger"))
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
                                    HStack {
                                        Spacer()
                                    }
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
                                            .background(
                                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                                    .fill(Color("rowsBg")))
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
        .alert(isPresented: self.$persons.showSessionAlert) {
            Alert(
                title: Text("Your session has expired"),
                message: Text("You will be redirected to log in again"),
                dismissButton: .default(Text("Ok!")) {
                    self.userAccount.clearKeychain()
                })
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
