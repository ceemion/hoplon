//
//  LendAndBorrowViewModel.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 06/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import Foundation

final class LendAndBorrowViewModel: ObservableObject {

//    @Published var person: LendBorrowPerson
    
//    @Published var lendBorrow = [LendBorrow]()

    @Published var type = "lent"
    @Published var name: String = ""
    @Published var amount: String = ""
    @Published var dueDate = Date()
    @Published var notes: String = ""
    @Published var lentOn = Date()

//    init(id: Int) {
//        fetch(id)
//    }

//    private func fetch(_ id: Int) {
//        HttpService().getPerson(id) { (person) in
////            print(person)
////            self.person = person
//            self.lendBorrow = person.data
//        }
//    }

    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }

    func resetForm() {
        self.type = "lent"
        self.name = ""
        self.amount = ""
        self.dueDate = Date()
        self.notes = ""
        self.lentOn = Date()
    }

    func save() {
        print("save data: \(type) \(amount) \(formatDate(dueDate))")
        _ = LBPayload(
            amount: self.amount,
            contact_id: 2,
            status: "pending",
            date_due: formatDate(self.dueDate),
            date: formatDate(self.lentOn),
            lb_type: self.type,
            notes: self.notes
        )
        self.resetForm()
    }
}
