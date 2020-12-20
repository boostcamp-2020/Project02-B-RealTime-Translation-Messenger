//
//  PersistenceManager.swift
//  PapagoTalk
//
//  Created by Byoung-Hwi Yoon on 2020/12/13.
//

import Foundation
import CoreData

final class PersistenceManager {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: name)
        container.loadPersistentStores { _, error in
            if let error = error {
                debugPrint(error.localizedDescription)
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    func fetch<T: NSManagedObject>(request: NSFetchRequest<T>) -> [T] {
        
        do {
            let data = try context.fetch(request)
            return data
        } catch {
            debugPrint(error.localizedDescription)
            return []
        }
    }
}
