//
//  CoreDataManager.swift
//  RandomContacts
//
//  Created by Ростислав Ермаченков on 05.03.2021.
//

import Foundation
import CoreData
import UIKit

//protocol CoreDataManaging {
//    func addRepoToFavorites(fullName: String)
//    func getFavorites() -> [FavoriteRepo]
//    func deleteRepoFromFavorites(repo: FavoriteRepo)
//}
//
//struct CoreDataManager: CoreDataManaging {
//
//    var context = (UIApplication.shared.delegate as! AppDelegate).coreDataStack.persistentContainer.viewContext
//    
//    func getFavorites() -> [FavoriteRepo] {
//        let fetchRequest: NSFetchRequest<FavoriteRepo> = FavoriteRepo.fetchRequest()
//        
//        do {
//            let repos = try context.fetch(fetchRequest)
//            return repos
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//        
//        return []
//    }
//    
//    func addRepoToFavorites(fullName: String) {
//        guard let entity = NSEntityDescription.entity(forEntityName: "FavoriteRepo", in: context) else { return }
//        let repoObject = FavoriteRepo(entity: entity, insertInto: context)
//        repoObject.fullName = fullName
//        
//        do {
//            try context.save()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
//    
//    func deleteRepoFromFavorites(repo: FavoriteRepo) {
//        context.delete(repo)
//        
//        do {
//            try context.save()
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//    }
//    
//}
