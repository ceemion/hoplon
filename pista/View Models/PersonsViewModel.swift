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
    @Published var loading: Bool = true

    @Published var firstname: String = ""
    @Published var lastname: String = ""
    @Published var email: String = ""
    @Published var phonenumber: String = ""

    @Published var error = Error(error: "")
    @Published var showSessionAlert: Bool = false

    init() {
        fetch()
    }

    func fetch() {
        fetchAggregators()
        fetchPersons()
    }

    func fetchAggregators() {
        HttpService().getAggregators { (aggregators, error) in
            if !error.error.isEmpty {
                self.error = error
                self.loading = false

                if error.error == "Signature has expired" {
                    self.showSessionAlert = true
                }
            } else {
                self.totalLent = aggregators.total_lent
                self.totalBorrowed = aggregators.total_borrowed
            }
        }
    }

    func fetchPersons() {
        HttpService().getPersons { (persons) in
            self.persons = persons
            self.loading = false
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
            email: self.email.lowercased(),
            phone_number: self.phonenumber
        )

        HttpService().createPerson(payload) { (person) in
            self.persons.append(person)
            self.clearForm()
        }
    }
}
