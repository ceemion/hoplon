//
//  HttpService.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 05/12/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import Foundation

class HttpService {

    private let contactsUrl:String = "\(Constants.Http.BASE_URL)/contacts"

    func getContacts(_ completion: @escaping ([Contact]) -> ()) {
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

           if let json = try? JSONDecoder().decode([Contact].self, from: data!) {
               print("la json: ", json)

               DispatchQueue.main.async {
                   completion(json)
               }
           }
       }

       task.resume()
   }
}
