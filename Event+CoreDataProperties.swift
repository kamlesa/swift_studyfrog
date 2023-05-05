//
//  Event+CoreDataProperties.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 5/5/2023.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var date: Date?
    @NSManaged public var recurrence: Bool
    @NSManaged public var type: Int32
    @NSManaged public var subject: Subject?
    @NSManaged public var list: User?
    @NSManaged public var name: String

}

extension Event : Identifiable {

}
