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
    case all
}

protocol DatabaseListener: AnyObject{
    //TODO: set up listener protocol
    var listenerType: ListenerType {get set}
    func onSubjectChange(change: DatabaseChange, subjects: [Subject])
}

protocol DatabaseProtocol: AnyObject {
    func cleanup()
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
    
    //TODO: set up protocol
}
