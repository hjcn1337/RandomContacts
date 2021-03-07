//
//  ContactsViewModel.swift
//  RandomContacts
//
//  Created by Ростислав Ермаченков on 06.03.2021.
//

import Foundation

struct ContactsViewModel {
    var contacts : [ContactViewModel] = [ContactViewModel]()
    var title: String? = "Contacts"
}

extension ContactsViewModel {
    
    init(contacts: [ContactViewModel]) {
        self.contacts = contacts
    }
    
}

struct ContactViewModel: ContactsCellViewModel {
    var imageUrlString: String
    var title: String
    var name: String
    var surname: String
    var phone: String
    var email: String
}

extension ContactViewModel {
    
    init(contact: Contact) {
        self.imageUrlString = contact.imageUrlString
        self.title = contact.title
        self.name = contact.name
        self.surname = contact.surname
        self.phone = contact.phone
        self.email = contact.email
        
    }
}
