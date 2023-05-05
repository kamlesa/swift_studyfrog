//
//  DatabaseProtocol.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 5/5/2023.
//

import Foundation

enum DatabaseChange {
    case add
    case remove
    case update
    
}

enum ListenerType {
    //TODO: add other cases!
    case subject
    case event
    case task
    case assessment
    case all
}

protocol DatabaseListener: AnyObject{
    //TODO: set up listener protocol
    var listenerType: ListenerType {get set}
    
    func onSubjectsChange(change: DatabaseChange, subjects: [Subject])
    
    func onSubjectChange(change: DatabaseChange, subjects: [Assessment])

    func onTasksChange(change: DatabaseChange, subjects: [Task])

    func onEventsChange(change: DatabaseChange, subjects: [Event])
    
}

protocol DatabaseProtocol: AnyObject {
    func cleanup()
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
    
    
    //TODO: set up protocol
    //subject:
    func addSubject(name: String, code: String) -> Subject
    func deleteSubject(assessment: Subject)
    
    //assessment:
    func addAssessment(name: String, worth: Double, subject: Subject) -> Assessment
    func deleteAssessment(assessment: Assessment)
    
    //task:
    func addTask(name: String, subject: Subject) -> Task
    func deleteTask(task: Task)
    
    //event:
    func addEvent(name: String, subject: Subject) -> Event
    func deleteEvent(event: Event)
}
