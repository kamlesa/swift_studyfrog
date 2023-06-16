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
    
    //let DEFAULT_LIST_NAME = "Default User List"
    //var currentUser: User?
    
    //TODO: insert the "     var teamHeroesFetchedResultsController: NSFetchedResultsController<Superhero>? " stuff....?
    //var subjectsFetchedResultsController: NSFetchedResultsController<Subject>?
    var todoFetchedResultsController: NSFetchedResultsController<ToDo>?

    //MARK: - init
    //FATAL ERROR = BAD!??
    override init() {
        persistentContainer = NSPersistentContainer(name: "StudyFrog-DataModel")
        persistentContainer.loadPersistentStores() {
            (description, error ) in
            if let error = error {
                fatalError("Failed to load Core Data Stack with error: \(error)")
            }
        }
        
        super.init()
        cleanup()
        //deleteTodos()
        //createDefaultTasks()
        //this if statement is for testing, if not todos in list, create some!
        if fetchTodos().count == 0{
            createDefaultTasks() //TODO: REMOVE WHEN WORKING!
        }
    }
    
    func deleteTodos(){
        //this function just deletes every to do - purpose is for testing only!
        let todoList = fetchTodos()
        for x in todoList{
            deleteTodo(todo: x)
        }
    }
    
    
    //MARK: - Database Protocol Basic Functions
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
        //adds listener
        listeners.addDelegate(listener)
        
        //if a todo listener.
        if listener.listenerType == .todo || listener.listenerType == .all {
            listener.onToDoChange(change: .update, todos: fetchTodos())
        }

    }
    
    func removeListener(listener: DatabaseListener) {
        //removes listener
        listeners.removeDelegate(listener)
    }
    

    
    //MARK: - Database Protocol Add/Delete
    
    func addToDo(name: String, deadline: Date) -> ToDo {
        //adds todo to core data!
        let todo = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: persistentContainer.viewContext) as! ToDo
        todo.name = name
        todo.deadline = deadline
        todo.progress = 0 //default progress is 0 - can be updated by user
        return todo
    }
    
    func deleteTodo(todo: ToDo) {
        //deletes task from core data!
        let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        let context = persistentContainer.viewContext
        if let todoName = todo.name {
            print(todoName)
            fetchRequest.predicate = NSPredicate(format: "name == %@", todoName) // Set a predicate to identify the specific object to update
        }
        do {
            let results = try context.fetch(fetchRequest)
            if let new_todo = results.first {
                // Modify the properties of the fetched object
                persistentContainer.viewContext.delete(new_todo)
                
                // Save the changes
                try context.save()
            }
        } catch {
            print("Error updating object: \(error)")
        }
        //persistentContainer.viewContext.delete(todo)
    }
    
    func updateProgress(todo: ToDo, progress: Float) {
        print(todo.progress)
        let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
        let context = persistentContainer.viewContext
        if let todoName = todo.name {
            print(todoName)
            fetchRequest.predicate = NSPredicate(format: "name == %@", todoName) // Set a predicate to identify the specific object to update
        }
        do {
            let results = try context.fetch(fetchRequest)
            if let todo = results.first {
                // Modify the properties of the fetched object
                todo.progress = progress
                
                // Save the changes
                try context.save()
            }
        } catch {
            print("Error updating object: \(error)")
        }
        print(todo.progress)
        //todo.progress = progress
    }
    
    func updateDeadline(todo: ToDo, deadline: Date) {
        todo.deadline = deadline
    }
    
    
    //MARK: - Fetch Functions
    
    func fetchTodos() -> [ToDo] {
        todoFetchedResultsController = nil
        if todoFetchedResultsController == nil {
            let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
            //TODO: IF YOU GET TIME - UPDATE THIS TO DISPLAY IN DATE ORDER INSTEAD.
            let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [nameSortDescriptor]
            todoFetchedResultsController = NSFetchedResultsController<ToDo>(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            todoFetchedResultsController?.delegate = self
            
            do {
                try todoFetchedResultsController?.performFetch()
            } catch {
                print("Fetch Request Failed: \(error)")
            }
        }
        
        var todos = [ToDo]()
        if todoFetchedResultsController?.fetchedObjects != nil {
            todos = (todoFetchedResultsController?.fetchedObjects)!
        }
        return todos
    }
    
    //MARK: - Other
    
    func createDefaultTasks() {
        //function to add some default tasks
        let _ = addToDo(name: "research 1", deadline: Date())
        let _ = addToDo(name: "research 2", deadline: Date())
        //let _ = addToDo(name: "study", deadline: Date())
        //let _ = addToDo(name: "piss my pants!", deadline: Date())
        cleanup()
    }
    
}
