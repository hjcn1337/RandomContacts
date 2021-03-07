//
//  CoreDataManager.swift
//  RandomContacts
//
//  Created by Ростислав Ермаченков on 05.03.2021.
//

import Foundation
import CoreData
import UIKit

protocol CoreDataManaging {
    //func addRepoToFavorites(fullName: String)
    func getContacts() -> [ContactEntity]
    func createContact(contact: ContactViewModel)
}

struct CoreDataManager: CoreDataManaging {

    var context = (UIApplication.shared.delegate as! AppDelegate).coreDataStack.persistentContainer.viewContext
    
    func getContacts() -> [ContactEntity] {
        let fetchRequest: NSFetchRequest<ContactEntity> = ContactEntity.fetchRequest()
        
        do {
            let contacts = try context.fetch(fetchRequest)
            return contacts
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return []
    }
    
    func createContact(contact: ContactViewModel) {
        guard let entity = NSEntityDescription.entity(forEntityName: "ContactEntity", in: context) else { return }
        let contactObject = ContactEntity(entity: entity, insertInto: context)
        contactObject.title = contact.title
        contactObject.name = contact.name
        contactObject.surname = contact.surname
        contactObject.phone = contact.phone
        contactObject.email = contact.email
        contactObject.imageUrlString = contact.imageUrlString
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
//    func deleteRepoFromFavorites(repo: ContactEntity) {
//        context.delete(repo)
//        
//        do {
//            try context.save()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
    
}
