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
    @Published var totalLent: Double = 0
    @Published var totalBorrowed: Double = 0

    @Published var firstname: String = ""
    @Published var lastname: String = ""
    @Published var email: String = ""
    @Published var phonenumber: String = ""

    init() {
        fetch()
    }

    func fetch() {
        fetchAggregators()
        fetchPersons()
    }

    func fetchAggregators() {
        HttpService().getAggregators { (aggregators) in
            self.totalLent = aggregators.total_lent
            self.totalBorrowed = aggregators.total_borrowed
        }
    }

    func fetchPersons() {
        HttpService().getPersons { (persons) in
            self.persons = persons
        }
    }

    func clearForm() {
        self.firstname = ""
        self.lastname = ""
        self.email = ""
        self.phonenumber = ""
    }

    func save() {
        let payload = PersonPayload(
            first_name: self.firstname,
            last_name: self.lastname,
            email: self.email,
            phone_number: self.phonenumber
        )

        HttpService().createPerson(payload) { (person) in
            self.persons.append(person)
            self.clearForm()
        }
    }
}
