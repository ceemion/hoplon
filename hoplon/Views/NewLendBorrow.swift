//
//  AddNewView.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 06/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import SwiftUI

struct NewLendBorrow: View {

    init() {
        UITableView.appearance().backgroundColor = .clear
    }

    @EnvironmentObject var model: LendAndBorrowViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker(selection: $model.type, label: Text("What action to perform?")) {
                        Text("Lent").tag("lent")
                        Text("Borrowed").tag("borrowed")
                    }.pickerStyle(SegmentedPickerStyle())
                }

                Section {
                    Label(text: "Full Name")
                    TextField("", text: $model.name)
                        .disabled(true)
                        .textFieldStyle(HoplonTextFieldStyle())
                }

                Section {
                    Label(text: "Amount (NGN)")
                    TextField("", text: $model.amount)
                        .keyboardType(.decimalPad)
                        .textFieldStyle(HoplonTextFieldStyle())
                }

                Section {
                    Label(text: "Due Date")
                    DatePicker(
                        selection: $model.dueDate,
                        displayedComponents: .date,
                        label: { Text("Select a date")}
                    )
                }

                Section {
                    Label(text: "Notes")
                    TextField("", text: $model.notes)
                        .textFieldStyle(HoplonTextFieldStyle())
                }

                Section {
                    Label(text: "You Lent On")
                    DatePicker(
                        selection: $model.lentOn,
                        displayedComponents: .date,
                        label: { Text("Select a date")}
                    )
                }
            }
            .navigationBarTitle(Text("Lent or Borrowed?"), displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    self.model.resetForm()
                    self.presentationMode.wrappedValue.dismiss()
                }) { Text("Cancel") },
                trailing: Button(action: {
                    self.model.save()
                    self.presentationMode.wrappedValue.dismiss()
                }) { Text("Save") }
            )
            .background(Color("sceneBg"))
        }
    }
}

struct NewLendBorrow_Previews: PreviewProvider {
    static var previews: some View {
        NewLendBorrow()
    }
}
