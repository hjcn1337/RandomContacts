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

    
    func getUsers(completion: @escaping ([Contact]) -> Void) {
        
        var contacts = [Contact]()
        
        fetcher.getUsers { [ weak self] (users) in
            self?.usersResponse = users
            guard let usersResponse = self?.usersResponse else { return }
            print(usersResponse)
            
//            let cells = usersResponse.results.map { (usersItem) in
//                return UsersViewModel.Cell.init(imageUrlString: usersItem.picture.thumbnail, name: usersItem.name.first, surname: usersItem.name.last, phone: usersItem.phone, email: usersItem.email)
//            }
//
//            let usersViewModel = UsersViewModel.init(cells: cells)
//
//            DispatchQueue.main.async {
//                completion(usersViewModel)
//            }
            
            
            contacts = usersResponse.results.map { usersItem in
                return Contact(imageUrlString: usersItem.picture.large, title: usersItem.name.title, name: usersItem.name.first, surname: usersItem.name.last, phone: usersItem.phone, email: usersItem.email)
            }
            
            completion(contacts)
        }
    }
    
}
