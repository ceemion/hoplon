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

    var body: some View {
        Text("Hello contact details!")
            .navigationBarTitle(Text("\(person.first_name) \(person.last_name)"))
            .navigationBarItems(trailing: Text("Add"))
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
