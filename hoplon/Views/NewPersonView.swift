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
                Text("ok")
            }
            .navigationBarTitle("New Person", displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
//                    self.model.resetForm()
                    self.presentationMode.wrappedValue.dismiss()
                }) { Text("Cancel") },
                trailing: Button(action: {
//                    self.model.save()
                    self.presentationMode.wrappedValue.dismiss()
                }) { Text("Save") }
            )
        }
    }
}

struct NewPersonView_Previews: PreviewProvider {
    static var previews: some View {
        NewPersonView()
    }
}
