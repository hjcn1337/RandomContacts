//
//  NetworkDataFetcher.swift
//  RandomContacts
//
//  Created by Ростислав Ермаченков on 05.03.2021.
//

import Foundation

protocol DataFetcher {
    func getUsers(response: @escaping (UsersResponse?) -> Void)
    func getUser(username: String, response: @escaping (UsersResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {

    let networking: Networking
    
    init(networking: Networking) {
        self.networking = networking
    }
    
    func getUsers(response: @escaping (UsersResponse?) -> Void) {
        
        let params = ["results": API.usersAmountString]
        networking.request(path: API.users, params: params) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: UsersResponse.self, from: data)
            response(decoded)
        }
    }
    
    func getUser(username: String, response: @escaping (UsersResponse?) -> Void) {
        
        let path = API.users + username
        networking.request(path: path, params: ["":""]) { (data, error) in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            let decoded = self.decodeJSON(type: UsersResponse.self, from: data)
            response(decoded)
        }
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
        return response
    }
}
