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
    
    private var pageNumber = 1
    private let firstPageNumber = 1
    private var isLoading = false
    
    private var usersResponse: UsersResponse?
    
    init() {
        self.networking = NetworkService()
        self.fetcher = NetworkDataFetcher(networking: networking)
    }

    
    func getUsers(completion: @escaping (UsersViewModel) -> Void) {
        fetcher.getUsers { [ weak self] (users) in
            self?.usersResponse = users
            guard let usersResponse = self?.usersResponse else { return }
            print(usersResponse)
            
            let cells = usersResponse.results.map { (usersItem) in
                return UsersViewModel.Cell.init(imageUrlString: usersItem.picture.thumbnail, name: usersItem.name.first, surname: usersItem.name.last, phone: usersItem.phone, email: usersItem.email)
            }
            
            let usersViewModel = UsersViewModel.init(cells: cells)
            
            completion(usersViewModel)
        }
    }
    
}
