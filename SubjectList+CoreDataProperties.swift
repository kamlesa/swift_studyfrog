//
//  SubjectList+CoreDataProperties.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 5/5/2023.
//
//

import Foundation
import CoreData


extension SubjectList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubjectList> {
        return NSFetchRequest<SubjectList>(entityName: "SubjectList")
    }

    @NSManaged public var name: String?
    @NSManaged public var subjects: NSSet?

}

// MARK: Generated accessors for subjects
extension SubjectList {

    @objc(addSubjectsObject:)
    @NSManaged public func addToSubjects(_ value: Subject)

    @objc(removeSubjectsObject:)
    @NSManaged public func removeFromSubjects(_ value: Subject)

    @objc(addSubjects:)
    @NSManaged public func addToSubjects(_ values: NSSet)

    @objc(removeSubjects:)
    @NSManaged public func removeFromSubjects(_ values: NSSet)

}

extension SubjectList : Identifiable {

}
