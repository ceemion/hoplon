//
//  HttpService.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 05/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import Foundation

class HttpService {

    private let aggregatorsUrl:String = "\(Constants.Http.BASE_URL)/aggregators"
    private let contactsUrl:String = "\(Constants.Http.BASE_URL)/contacts"

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
                print("Response Data: ", json)
            } else {
                print("Catch json serialization error.")
            }
        }

        task.resume()
    }
}
