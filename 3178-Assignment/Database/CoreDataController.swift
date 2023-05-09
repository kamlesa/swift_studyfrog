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
    
    let DEFAULT_LIST_NAME = "Default User List"
    var currentUser: User?
    
    //TODO: insert the "     var teamHeroesFetchedResultsController: NSFetchedResultsController<Superhero>? " stuff....?
    var subjectsFetchedResultsController: NSFetchedResultsController<Subject>?
    var tasksFetchedResultsController: NSFetchedResultsController<ToDo>?

    //FATAL ERROR = BAD???
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
        if fetchSubjects().count == 0{
            createDefaultTasks() //TODO: REMOVE WHEN WORKING!
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
        listeners.addDelegate(listener)

        if listener.listenerType == .subject || listener.listenerType == .all {
            listener.onSubjectsChange(change: .update, subjects: fetchSubjects())
        }
        
        if listener.listenerType == .task || listener.listenerType == .all {
            listener.onTasksChange(change: .update, tasks: fetchTasks())
        }
        
        if listener.listenerType == .assessment || listener.listenerType == .all {
            listener.onSubjectChange(change: .update, assessments: fetchAssessments())
        }
        
        if listener.listenerType == .event || listener.listenerType == .all {
            listener.onEventsChange(change: .update, events: fetchEvents())
        }
    }
    
    func removeListener(listener: DatabaseListener) {
        listeners.removeDelegate(listener)

    }
    
    //MARK: - Database Protocol Add _ To List
    
    func addSubjectToList(subject: Subject, list: User) -> Bool {
        //TODO
        return false
    }
    
    func addTaskToList(task: ToDo, list: User) -> Bool {
        //TODO
        return false
    }
    
    func addEventToList(task: Event, list: User) -> Bool {
        //TODO
        return false
    }
    
    //MARK: - Database Protocol Add/Delete
    
    func addSubject(name: String, code: String) -> Subject {
        let subject = NSEntityDescription.insertNewObject(forEntityName: "Subject", into: persistentContainer.viewContext) as! Subject
        subject.name = name
        subject.code = code
        return subject
    }
    
    func deleteSubject(subject: Subject) {
        persistentContainer.viewContext.delete(subject)
    }
    
    func addAssessment(name: String, worth: Double) -> Assessment {
        let assessment = NSEntityDescription.insertNewObject(forEntityName: "Assessment", into: persistentContainer.viewContext) as! Assessment
        assessment.name = name
        assessment.worth = worth
        return assessment
    }
    
    func deleteAssessment(assessment: Assessment) {
        persistentContainer.viewContext.delete(assessment)
    }
    
    func addTask(name: String, subject: Subject) -> ToDo {
        let task = NSEntityDescription.insertNewObject(forEntityName: "ToDo", into: persistentContainer.viewContext) as! ToDo
        task.name = name
        return task
    }
    
    func deleteTask(task: ToDo) {
        persistentContainer.viewContext.delete(task)
    }
    
    func addEvent(name: String, date: Date) -> Event {
        let event = NSEntityDescription.insertNewObject(forEntityName: "Event", into: persistentContainer.viewContext) as! Event
        event.name = name
        event.date = date
        return event
    }
    
    func deleteEvent(event: Event) {
        persistentContainer.viewContext.delete(event)
    }
    
    //MARK: - Fetch Functions
    
    func fetchSubjects() -> [Subject] {
        if subjectsFetchedResultsController == nil {
            let fetchRequest: NSFetchRequest<Subject> = Subject.fetchRequest()
            let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [nameSortDescriptor]
            subjectsFetchedResultsController = NSFetchedResultsController<Subject>(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            subjectsFetchedResultsController?.delegate = self
            
            do {
                try subjectsFetchedResultsController?.performFetch()
            } catch {
                print("Fetch Request Failed: \(error)")
            }
        }
        var subjects = [Subject]()
        if subjectsFetchedResultsController?.fetchedObjects != nil {
            subjects = (subjectsFetchedResultsController?.fetchedObjects)!
        }
        return subjects
    }
    
    func fetchTasks() -> [ToDo] {
        if tasksFetchedResultsController == nil {
            let fetchRequest: NSFetchRequest<ToDo> = ToDo.fetchRequest()
            let nameSortDescriptor = NSSortDescriptor(key: "name", ascending: true)
            fetchRequest.sortDescriptors = [nameSortDescriptor]
            tasksFetchedResultsController = NSFetchedResultsController<ToDo>(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
            tasksFetchedResultsController?.delegate = self
            
            do {
                try tasksFetchedResultsController?.performFetch()
            } catch {
                print("Fetch Request Failed: \(error)")
            }
        }
        
        var tasks = [ToDo]()
        if tasksFetchedResultsController?.fetchedObjects != nil {
            tasks = (tasksFetchedResultsController?.fetchedObjects)!
        }
        return tasks
    }
    
    func fetchAssessments() -> [Assessment] {
        //set up
        return []
    }
    
    func fetchEvents() -> [Event] {
        //set up
        return []
    }
    
    //MARK: - Other
    
    func createDefaultTasks() {
        let default_subject = addSubject(name: "iOS App Dev", code: "FIT3178")
        let _ = addTask(name: "research 1", subject: default_subject)
        let _ = addTask(name: "update UI 2", subject: default_subject)
        let _ = addTask(name: "watch pre-workshop videos 3", subject: default_subject)
        let _ = addTask(name: "test", subject: default_subject)
        cleanup()
    }
    
}
