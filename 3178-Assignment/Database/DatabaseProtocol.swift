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
    case subject
    //case event
    case todo
    case assessment
    case all
}

protocol DatabaseListener: AnyObject{
    var listenerType: ListenerType {get set}
    
    func onToDoChange(change: DatabaseChange, todos: [ToDo])
    func onSubjectChange(change: DatabaseChange, subjects: [Subject])
    func onAllAssessmentsChange(change: DatabaseChange, assessments: [Assessment])

    
}

protocol DatabaseProtocol: AnyObject {
    func cleanup()
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
    

    //todo:
    func addToDo(name: String, deadline: Date) -> ToDo
    func deleteTodo(todo: ToDo)
    func updateProgress(todo: ToDo, progress: Float)
    func updateDeadline(todo: ToDo, deadline: Date)
//
//    //event:
//    func addEvent(name: String, date: Date) -> Event
//    func deleteEvent(event: Event)
}

protocol FirebaseProtocol: AnyObject {
    //this is seperated so I don't have to implement these methods into the core data controller
    //however if you wanted all database stuff to be handled by firebase/core you just make either controller inherit both protocols
    func cleanup()
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
    
    var defaultSubject: Subject {get}
    var currentSubjectA: [Assessment] {get set}
    //subject:
    func addSubject(name: String, code: String, goal_grade: Int) -> Subject
    func deleteSubject(subject: Subject)
    func updateSubject(subject: Subject, fieldName: String, newValue: Any)
    
    //assessment:
    func addAssessment(name: String, worth: Int) -> Assessment //, subject:Subject
    func deleteAssessment(assessment: Assessment)
    func addAssessmentToSubject(assessment: Assessment, subject: Subject) -> Bool
    func updateAssessment(assessment: Assessment, fieldName: String, newValue: Any)
    func getAssessments(subjectName: String)
 }
