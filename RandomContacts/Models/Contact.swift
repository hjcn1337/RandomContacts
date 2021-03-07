//
//  Contact.swift
//  RandomContacts
//
//  Created by Ростислав Ермаченков on 06.03.2021.
//

import Foundation

class Contact: ContactsCellViewModel {
    let imageUrlString: String
    let title: String
    let name: String
    let surname: String
    let phone: String
    let email: String

    init(imageUrlString: String, title: String, name: String, surname: String, phone: String, email: String) {
        self.imageUrlString = imageUrlString
        self.title = title
        self.name = name
        self.surname = surname
        self.phone = phone
        self.email = email
        
    }
}
