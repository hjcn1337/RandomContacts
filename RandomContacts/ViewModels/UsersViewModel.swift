//
//  UsersViewModel.swift
//  RandomContacts
//
//  Created by Ростислав Ермаченков on 05.03.2021.
//

import Foundation

struct UsersViewModel {
    struct Cell: UsersCellViewModel {
        let imageUrlString: String
        let name: String
        let surname: String
        let phone: String
        let email: String
    }
 
    let cells: [Cell]
}
