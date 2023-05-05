//
//  Assessment+CoreDataProperties.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 5/5/2023.
//
//

import Foundation
import CoreData


extension Assessment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Assessment> {
        return NSFetchRequest<Assessment>(entityName: "Assessment")
    }

    @NSManaged public var worth: Double
    @NSManaged public var mark: Double
    @NSManaged public var name: String?
    @NSManaged public var subject: Subject?

}

extension Assessment : Identifiable {

}
