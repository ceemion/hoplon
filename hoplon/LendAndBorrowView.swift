//
//  SwiftUIView.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 24/11/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import SwiftUI

struct Contact: Identifiable, Codable {
    let id: Int
    let user_id: Int
    let first_name, last_name, email, phone_number: String
    let lendborrow_count: Int
}

struct LendAndBorrowView: View {
    init() {
        fetchData()
//        // To remove only extra separators below the list:
//        UITableView.appearance().tableFooterView = UIView()
//
//        // To remove all separators including the actual ones:
//        UITableView.appearance().separatorStyle = .none
    }

    let contacts: [Contact] = [
        .init(id: 1, user_id: 1, first_name: "Simeon", last_name: "Logik", email: "sl@email.com", phone_number: "0812", lendborrow_count: 3),
        .init(id: 2, user_id: 1, first_name: "Jinx", last_name: "King", email: "sl@email.com", phone_number: "0812", lendborrow_count: 0),
        .init(id: 3, user_id: 1, first_name: "Joy", last_name: "Peace", email: "sl@email.com", phone_number: "0812", lendborrow_count: 34)
    ]

    var body: some View {
        NavigationView {
            List {
                HStack {
                    SummaryView(amount: "230,000k")
                        .padding()
                        .border(Color.green)
                        .foregroundColor(Color.green)
                    Spacer()
                    SummaryView(amount: "2.3k")
                        .padding()
                        .border(Color.red)
                        .foregroundColor(Color.red)
                }

                ForEach(contacts) { contact in
                    ContactRowView(contact: contact)
                        .font(.body)
                        .padding()
                        .border(Color.gray)
                }
            }.navigationBarTitle(Text("Lend & Borrow"))
        }
    }
}

struct SummaryView: View {
    let amount: String

    var body: some View {
        Text(amount)
    }
}

struct ContactRowView: View {
    let contact: Contact

    var body: some View {
        HStack {
            Text("\(contact.first_name) \(contact.last_name)")
            Spacer()
            Text(String(contact.lendborrow_count))
        }
    }
}

 private func fetchData() -> Void {
//        let testUrl:String = "https://my-forecast-api.herokuapp.com/api/v1/contacts"
        let testUrl:String = "http://localhost:5001/api/v1/contacts"
        let url = URL(string: testUrl)!

        // Remove error/retry button/text
//        self.clearErrors()
//        self.showSpinner(onView: DevotionalContentStackView)

        let sharedSession = URLSession.shared
        let task = sharedSession.dataTask(with: url) { data, response, error in
//            self.removeSpinner()

            if let error = error {
                print("my Client Error")
                print(error)

                //DispatchQueue.main.async {
                    //self.handleClientError(error.localizedDescription)
                //}

                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("my Server Response")
                    print(response as Any)

                    //DispatchQueue.main.async {
                        //self.handleServerError(response)
                    //}

                    return
            }

            if let json = try? JSONDecoder().decode([Contact].self, from: data!) {
                print("la json: ", json)

//                DispatchQueue.main.async {
//                    contacts = json
//                }
            }
        }

        task.resume()
    }

struct LendAndBorrowView_Previews: PreviewProvider {
    static var previews: some View {
        LendAndBorrowView()
    }
}
