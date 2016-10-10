//
//  PlaycallerModel.swift
//  Playcaller
//
//  Created by Kam Dahlin on 10/8/16.
//  Copyright © 2016 Kam Dahlin. All rights reserved.
//

import Foundation
import CoreData

enum PlaycallerModelType {
    case sql
    case inMemory
    
    var storeDescriptionForType: NSPersistentStoreDescription {
        switch self {
        case .sql:
            let sqlDescription = NSPersistentStoreDescription()
            sqlDescription.type = NSSQLiteStoreType
            return sqlDescription
        case .inMemory:
            let inMemoryDescription = NSPersistentStoreDescription()
            inMemoryDescription.type = NSInMemoryStoreType
            return inMemoryDescription
        }
    }
}

class PlaycallerModel {
    let persistentContainer: NSPersistentContainer
    let type: PlaycallerModelType
    
    init(withModelName name: String = "Playcaller", type: PlaycallerModelType = .sql) {
        self.persistentContainer = NSPersistentContainer(name: name)
        self.type = type
        self.persistentContainer.persistentStoreDescriptions = [self.type.storeDescriptionForType]
    }
    
    func load(_ result: @escaping (Error?) -> Void) {
        self.persistentContainer.loadPersistentStores { (store, error) in
            result(error)
        }
    }
    
    
}
