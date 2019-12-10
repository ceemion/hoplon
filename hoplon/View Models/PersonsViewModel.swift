//
//  ContactsViewModel.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 05/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import Foundation

final class PersonsViewModel: ObservableObject {

    @Published var persons = [Person]()
    @Published var totalLent: Int = 0
    @Published var totalBorrowed: Int = 0

    init() {
        fetchAggregators()
    }

    private func fetchAggregators() {
        HttpService().getAggregators { (aggregators) in
            self.totalLent = aggregators.total_lent
            self.totalBorrowed = aggregators.total_borrowed
            self.persons = aggregators.contacts
        }
    }

    private func fetchContacts() {
        HttpService().getPersons { (persons) in
            self.persons = persons
        }
    }
}
