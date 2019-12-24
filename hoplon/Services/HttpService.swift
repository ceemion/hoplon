//
//  HttpService.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 05/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import Foundation
import Alamofire
import SwiftKeychainWrapper

class HttpService {

    private let loginUrl:String = "\(Constants.Http.BASE_URL)/auth/sign_in"
    private let registerUrl:String = "\(Constants.Http.BASE_URL)/auth/register"
    private let logoutUrl:String = "\(Constants.Http.BASE_URL)/auth/sign_out"
    private let aggregatorsUrl:String = "\(Constants.Http.BASE_URL_V1)/aggregators"
    private let contactsUrl:String = "\(Constants.Http.BASE_URL_V1)/contacts"
    private let lendBorrowUrl:String = "\(Constants.Http.BASE_URL_V1)/lend_borrows"

    func retrieveJWT() -> String {
        return KeychainWrapper.standard.string(forKey: "userJWToken") ?? ""
    }

    func auth(_ type: String, _ p: Dictionary<String, String>, _ completion: @escaping (User, Error, Any) -> ()) {
        let url = type == "login" ? URL(string: loginUrl)! : URL(string: registerUrl)!

        let payload: [String: [String: String]] = [
            "user": p
        ]

        AF.request(url, method: .post, parameters: payload).responseJSON { (response) in
            let emptyUser = User(id: 0, email: "", first_name: "", last_name: "", phone_number: "")
            guard let data = response.data else { return }

            //debugPrint(response)

            if response.response!.statusCode > 400 {
                completion(emptyUser, Error(error: "Invalid email or password."), "")
                return
            }

            do {
                let json = try JSONDecoder().decode(User.self, from: data)
                let jwt = response.response?.headers["Authorization"] ?? ""

                completion(json, Error(error: ""), jwt)
            } catch let error {
                print("json decoder decode auth user catch error")
                print(error)

                completion(emptyUser, Error(error: "An error has occurred, please try again"), "")
            }
        }
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

        var request = URLRequest(url: url)
        request.setValue(retrieveJWT(), forHTTPHeaderField: "Authorization")

         let sharedSession = URLSession.shared
         let task = sharedSession.dataTask(with: request) { data, response, error in
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

        var request = URLRequest(url: url)
        request.setValue(retrieveJWT(), forHTTPHeaderField: "Authorization")

        let sharedSession = URLSession.shared
        let task = sharedSession.dataTask(with: request) { data, response, error in
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

                do {
                    let jsonResult:NSDictionary! = try JSONSerialization.jsonObject(with: data!, options:JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    print("server res: ", (jsonResult as AnyObject)["error"]!! as! String)
                } catch {
                    print("catch nsdic do")
                }

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
        request.setValue(retrieveJWT(), forHTTPHeaderField: "Authorization")
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
        request.setValue(retrieveJWT(), forHTTPHeaderField: "Authorization")
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
