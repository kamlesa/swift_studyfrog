//
//  Task+CoreDataProperties.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 5/5/2023.
//
//

import Foundation
import CoreData


extension ToDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDo> {
        return NSFetchRequest<ToDo>(entityName: "ToDo")
    }

    @NSManaged public var deadline: Date?
    @NSManaged public var name: String?
    @NSManaged public var subject: Subject?
    @NSManaged public var list: User?

}

extension ToDo : Identifiable {

}
