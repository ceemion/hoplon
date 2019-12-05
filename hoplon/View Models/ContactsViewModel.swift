//
//  ContactsViewModel.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 05/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import Foundation

final class ContactsViewModel: ObservableObject {
    @Published var contacts = [Contact]()

    init() {
        fetchContacts()
    }

    private func fetchContacts() {
        HttpService().getContacts { (contacts) in
            self.contacts = contacts
        }
    }
}
