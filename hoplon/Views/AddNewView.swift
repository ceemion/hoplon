//
//  AddNewView.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 06/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import SwiftUI

struct AddNewView: View {

    init(){
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
                    HStack(alignment: .center, spacing: 10) {
                        TextField("", text: $model.name)
                            .textFieldStyle(HoplonTextFieldStyle())
                        Image(systemName: "person.badge.plus.fill")
                            .imageScale(.large)
                    }
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
            .background(Color.white)
        }
    }
}

struct Label: View {
    let text: String

    var body: some View {
        Text(text.uppercased())
            .font(.headline)
    }
}

public struct HoplonTextFieldStyle : TextFieldStyle {
    public func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(.body)
            .padding(10)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(Color.primary.opacity(0.1), lineWidth: 1))
    }
}

struct AddNewView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewView()
    }
}
