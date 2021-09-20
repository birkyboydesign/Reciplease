//
//  CoreDataStack.swift
//  Reciplease
//
//  Created by Birkyboy on 15/09/2021.
//

import Foundation
import CoreData

open class CoreDataStack {
    static let modelName = "Reciplease"

    /// Intialize the coredata  model.
    static let model: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()

    init() {}

    /// Initialize a context.
    lazy var mainContext: NSManagedObjectContext = {
        return persitentContainer.viewContext
    }()

    /// Create a persistent container.
    var persitentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataStack.modelName, managedObjectModel: CoreDataStack.model)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    /// Save context.
    /// - Parameter context: Pass in the context to be saved.
    func saveContext(_ context: NSManagedObjectContext) {
        context.perform {
            do {
                try context.save()
            } catch let error as NSError {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
}
