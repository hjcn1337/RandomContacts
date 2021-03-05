//
//  TestNetworkManager.swift
//  RandomContacts
//
//  Created by Ростислав Ермаченков on 05.03.2021.
//

import Foundation

class TestNetworkManager {
    
    func getUsers() {
        var urlString = "https://randomuser.me/api/?results=1000"
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            if let data = data {
                
                do {
                    let decoder = JSONDecoder()
                    let repos = try decoder.decode(UsersResponse.self, from: data)
                    print(repos as Any)
                } catch DecodingError.dataCorrupted(let context) {
                    print(context)
                } catch DecodingError.keyNotFound(let key, let context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch DecodingError.valueNotFound(let value, let context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch DecodingError.typeMismatch(let type, let context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
                
                /*let decoder = JSONDecoder()
                repos = try? decoder.decode(ReposResponse.self, from: data)*/
                print("data")
                print(data)
                
                
            }
        }
        task.resume()
        
    }
}
