//
//  LendAndBorrowViewModel.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 06/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import Foundation

final class LendAndBorrowViewModel: ObservableObject {

    @Published var totalLent: Int = 0
    @Published var totalBorrowed: Int = 0
    @Published var contacts = [Contact]()

    init() {
        fetch()
    }

    private func fetch() {
        HttpService().getAggregators { (aggregators) in
            self.totalLent = aggregators.total_lent
            self.totalBorrowed = aggregators.total_borrowed
            self.contacts = aggregators.contacts
        }
    }
}
