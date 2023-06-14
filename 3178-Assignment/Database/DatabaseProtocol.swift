//
//  DatabaseProtocol.swift
//  3178-Assignment
//  These protocols were inspired by the Week 6 Labs.
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
    //case subject
    //case event
    case todo
    //case assessment
    case all
}

protocol DatabaseListener: AnyObject{
    var listenerType: ListenerType {get set}
    
   //func onSubjectsChange(change: DatabaseChange, subjects: [Subject])
    
    //func onSubjectChange(change: DatabaseChange, assessments: [Assessment])

    func onToDoChange(change: DatabaseChange, todos: [ToDo])

    //func onEventsChange(change: DatabaseChange, events: [Event])
    
}

protocol DatabaseProtocol: AnyObject {
    func cleanup()
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
    
//
//    //subject:
//    func addSubject(name: String, code: String) -> Subject
//    func deleteSubject(subject: Subject)
//
//    //assessment:
//    func addAssessment(name: String, worth: Double) -> Assessment
//    func deleteAssessment(assessment: Assessment)
//    //func addAssessmentToSubject(assessment: Assessment, subject: Subject)

    //todo:
    func addToDo(name: String, deadline: Date) -> ToDo
    func deleteTodo(todo: ToDo)
//
//    //event:
//    func addEvent(name: String, date: Date) -> Event
//    func deleteEvent(event: Event)
}
