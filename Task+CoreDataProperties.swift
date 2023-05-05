//
//  Task+CoreDataProperties.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 5/5/2023.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var name: String?
    @NSManaged public var deadline: Date?
    @NSManaged public var subject: Subject?

}

extension Task : Identifiable {

}
