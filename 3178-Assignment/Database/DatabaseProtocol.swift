//
//  DatabaseProtocol.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 5/5/2023.
//

//TODO: NOT 100% SURE HOW THIS WILL BE SETUP .. . . .

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
    
    func onSubjectChange(change: DatabaseChange, assessments: [Assessment])

    func onTasksChange(change: DatabaseChange, tasks: [Task])

    func onEventsChange(change: DatabaseChange, events: [Event])
    
}

protocol DatabaseProtocol: AnyObject {
    func cleanup()
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
    
    //TODO: set up protocol
    //TODO: set up the connection between subject and ass/task/event!?
    //list:
    var currentUser: User? {get set}
    func addSubjectToList(subject: Subject, list: User) -> Bool
    func addTaskToList(task: Task, list: User) -> Bool
    func addEventToList(task: Event, list: User) -> Bool
    
    //subject:
    func addSubject(name: String, code: String) -> Subject
    func deleteSubject(subject: Subject)
    
    //assessment:
    func addAssessment(name: String, worth: Double) -> Assessment
    func deleteAssessment(assessment: Assessment)
    //func addAssessmentToSubject(assessment: Assessment, subject: Subject)
    
    //task:
    func addTask(name: String, subject: Subject) -> Task
    func deleteTask(task: Task)
    
    //event:
    func addEvent(name: String, date: Date) -> Event
    func deleteEvent(event: Event)
}
