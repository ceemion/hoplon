//
//  NewContactView.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 10/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import SwiftUI

struct NewPersonView: View {

    @EnvironmentObject var model: PersonsViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 5) {
                        Label(text: "First Name")
                        HStack(alignment: .center, spacing: 10) {
                            TextField("", text: $model.firstname)
                                .textFieldStyle(HoplonTextFieldStyle())
                            Image(systemName: "person.badge.plus.fill")
                                .imageScale(.large)
                        }
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Label(text: "Last Name")
                        TextField("", text: $model.lastname)
                            .textFieldStyle(HoplonTextFieldStyle())
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Label(text: "Email")
                        TextField("", text: $model.email)
                            .keyboardType(.emailAddress)
                            .textFieldStyle(HoplonTextFieldStyle())
                    }

                    VStack(alignment: .leading, spacing: 5) {
                        Label(text: "Phone Number")
                        TextField("", text: $model.phonenumber)
                            .keyboardType(.phonePad)
                            .textFieldStyle(HoplonTextFieldStyle())
                    }
                }
                .padding(10)
            }
            .navigationBarTitle("New Person", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    self.model.clearForm()
                    self.presentationMode.wrappedValue.dismiss()
                    }) { Text("Cancel") }
                    .accentColor(Color("primary")),
                trailing: Button(action: {
                    self.model.save()
                    self.presentationMode.wrappedValue.dismiss()
                }) { Text("Save") }
                    .accentColor(Color("primary"))
            )
        }
    }
}

struct NewPersonView_Previews: PreviewProvider {
    static var previews: some View {
        NewPersonView()
    }
}
