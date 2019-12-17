//
//  HttpService.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 05/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import Foundation

class HttpService {

    private let loginUrl:String = "\(Constants.Http.BASE_URL)/auth/sign_in"
    private let logoutUrl:String = "\(Constants.Http.BASE_URL)/auth/sign_out"
    private let aggregatorsUrl:String = "\(Constants.Http.BASE_URL_V1)/aggregators"
    private let contactsUrl:String = "\(Constants.Http.BASE_URL_V1)/contacts"
    private let lendBorrowUrl:String = "\(Constants.Http.BASE_URL_V1)/lend_borrows"

    func loginUser(_ email: String, _ password: String, _ completion: @escaping (User, Any) -> ()) {
        let url = URL(string: loginUrl)!

        let payload: [String: [String: String]] = [
            "user": [
                "email": email,
                "password": password
            ]
        ]

        guard let httpBody = try? JSONEncoder().encode(payload) else { return }

        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody

        let sharedSession = URLSession.shared
        let task = sharedSession.dataTask(with: request) { data, response, error in
            if let error = error {
                print("my Client Error")
                print(error)

                //DispatchQueue.main.async {
                //    self.handleClientError(error.localizedDescription)
                //}

                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("my Server Response")
                    print(response as Any)

                    //DispatchQueue.main.async {
                    //    self.handleServerError(response)
                    //}

                    return
            }

            if let json = try? JSONDecoder().decode(User.self, from: data!) {
//                print("Login Response Data: ", httpResponse.allHeaderFields["Authorization"]!)
                let jwt = httpResponse.allHeaderFields["Authorization"]!

                DispatchQueue.main.async {
                    completion(json, jwt)
                }
            } else {
                print("Catch json serialization error.")
            }
        }

        task.resume()
    }

    func logout(_ completion: @escaping (Int) -> ()) {
        let url = URL(string: logoutUrl)!

        var request = URLRequest(url: url)

        request.httpMethod = "DELETE"

        let sharedSession = URLSession.shared
        let task = sharedSession.dataTask(with: request) { data, response, error in
            if let error = error {
                print("my Client Error")
                print(error)

                //DispatchQueue.main.async {
                //    self.handleClientError(error.localizedDescription)
                //}

                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("my Server Response")
                    print(response as Any)

                    //DispatchQueue.main.async {
                    //    self.handleServerError(response)
                    //}

                    return
            }

            DispatchQueue.main.async {
                completion(httpResponse.statusCode)
            }
        }

        task.resume()
    }

    func getAggregators(_ completion: @escaping (Aggregator) -> ()) {
         let url = URL(string: aggregatorsUrl)!

         let sharedSession = URLSession.shared
         let task = sharedSession.dataTask(with: url) { data, response, error in
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

            if let json = try? JSONDecoder().decode(Aggregator.self, from: data!) {
                //print("la json: ", json)

                DispatchQueue.main.async {
                    completion(json)
                }
            }
        }

        task.resume()
    }

    func getPersons(_ completion: @escaping ([Person]) -> ()) {
        let url = URL(string: contactsUrl)!

        let sharedSession = URLSession.shared
        let task = sharedSession.dataTask(with: url) { data, response, error in
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

           if let json = try? JSONDecoder().decode([Person].self, from: data!) {
//               print("la json: ", json)

               DispatchQueue.main.async {
                   completion(json)
               }
           }
       }

       task.resume()
    }

    func createPerson(_ payload: PersonPayload, _ completion: @escaping (Person) -> ()) {
        let url = URL(string: contactsUrl)!

        guard let httpBody = try? JSONEncoder().encode(payload) else { return }

        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody

        let sharedSession = URLSession.shared
        let task = sharedSession.dataTask(with: request) { data, response, error in

            if let error = error {
                print("my Client Error")
                print(error)
                
                //DispatchQueue.main.async {
                //    self.handleClientError(error.localizedDescription)
                //}

                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("my Server Response")
                    print(response as Any)

                    //DispatchQueue.main.async {
                    //    self.handleServerError(response)
                    //}

                    return
            }

            if let json = try? JSONDecoder().decode(Person.self, from: data!) {
                DispatchQueue.main.async {
                    completion(json)
                }
                print("Create Response Data: ", json)
            } else {
                print("Catch json serialization error.")
            }
        }

        task.resume()
    }

    func createLendBorrow(_ payload: LBPayload, _ completion: @escaping (LendBorrow) -> ()) {
        let url = URL(string: lendBorrowUrl)!

        guard let httpBody = try? JSONEncoder().encode(payload) else { return }

        var request = URLRequest(url: url)

        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = httpBody

        let sharedSession = URLSession.shared
        let task = sharedSession.dataTask(with: request) { data, response, error in

            if let error = error {
                print("my Client Error")
                print(error)

                //DispatchQueue.main.async {
                //    self.handleClientError(error.localizedDescription)
                //}

                return
            }

            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("my Server Response")
                    print(response as Any)

                    //DispatchQueue.main.async {
                    //    self.handleServerError(response)
                    //}

                    return
            }

            if let json = try? JSONDecoder().decode(LendBorrow.self, from: data!) {
                DispatchQueue.main.async {
                    completion(json)
                }
                print("Create Response Data: ", json)
            } else {
                print("Catch json serialization error.")
            }
        }

        task.resume()
    }
}
