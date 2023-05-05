//
//  CoreDataController.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 5/5/2023.
//

import UIKit
import CoreData

class CoreDataController: NSObject, DatabaseProtocol, NSFetchedResultsControllerDelegate {
    //TODO: SET UP!
    //MARK: - Variables
    var listeners = MulticastDelegate<DatabaseListener>()
    var persistentContainer: NSPersistentContainer

    //TODO: FATAL ERROR = BAD???
    override init() {
        persistentContainer = NSPersistentContainer(name: "StudyFrog-DataModel")
        persistentContainer.loadPersistentStores() {
            (description, error ) in
            if let error = error {
                fatalError("Failed to load Core Data Stack with error: \(error)")
            }
        }
        
        super.init()
    }
    
    
    //MARK: - Database Protocol Functions
    func cleanup() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                fatalError("Failed to save changes to Core Data with error: \(error)")
            }
        }
    }
    
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        //TODO: UPDATE FOR LISTENER TYPE!
    }
    
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)

    }
    
    //MARK: - Other
}
