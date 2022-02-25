//
//  CoreDataStack.swift
//  Event's
//
//  Created by David Da Silva on 23/02/2022.
//

import Foundation
import CoreData

final class CoreDataStack {
    
    // MARK: - Properties
    private let persistenContainerName = "Events"
    
    // MARK: - Singleton
    static let sharedInstance = CoreDataStack()
    
    // MARK: - Public
    var viewContext: NSManagedObjectContext {
        return CoreDataStack.sharedInstance.persistenContainer.viewContext
    }
    
    // MARK: - Private
    private init() {}
    
    private lazy var persistenContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: persistenContainerName)
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo) for: \(storeDescription.description)")
            }
        })
        return container
    }()
}
