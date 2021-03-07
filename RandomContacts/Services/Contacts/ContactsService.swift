//
//  ContactsService.swift
//  RandomContacts
//
//  Created by Ростислав Ермаченков on 05.03.2021.
//

import Foundation

class ContactsService {
    var networking: Networking
    var fetcher: DataFetcher
    
    private var usersResponse: UsersResponse?
    
    init() {
        self.networking = NetworkService()
        self.fetcher = NetworkDataFetcher(networking: networking)
    }

    
    func getContacts(completion: @escaping ([Contact]) -> Void) {
        
        var contacts = [Contact]()
        
        fetcher.getUsers { [ weak self] (users) in
            self?.usersResponse = users
            guard let usersResponse = self?.usersResponse else { return } 
            
            contacts = usersResponse.results.map { usersItem in
                return Contact(imageUrlString: usersItem.picture.large, title: usersItem.name.title, name: usersItem.name.first, surname: usersItem.name.last, phone: usersItem.phone, email: usersItem.email)
            }
            
            completion(contacts)
        }
    }
    
}
