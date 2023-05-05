//
//  Subject+CoreDataProperties.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 5/5/2023.
//
//

import Foundation
import CoreData


extension Subject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Subject> {
        return NSFetchRequest<Subject>(entityName: "Subject")
    }

    @NSManaged public var code: String?
    @NSManaged public var colour: Int32
    @NSManaged public var goal: Double
    @NSManaged public var grade: Double
    @NSManaged public var name: String?
    @NSManaged public var assessments: NSSet?
    @NSManaged public var events: NSSet?
    @NSManaged public var list: User?
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for assessments
extension Subject {

    @objc(addAssessmentsObject:)
    @NSManaged public func addToAssessments(_ value: Assessment)

    @objc(removeAssessmentsObject:)
    @NSManaged public func removeFromAssessments(_ value: Assessment)

    @objc(addAssessments:)
    @NSManaged public func addToAssessments(_ values: NSSet)

    @objc(removeAssessments:)
    @NSManaged public func removeFromAssessments(_ values: NSSet)

}

// MARK: Generated accessors for events
extension Subject {

    @objc(addEventsObject:)
    @NSManaged public func addToEvents(_ value: Event)

    @objc(removeEventsObject:)
    @NSManaged public func removeFromEvents(_ value: Event)

    @objc(addEvents:)
    @NSManaged public func addToEvents(_ values: NSSet)

    @objc(removeEvents:)
    @NSManaged public func removeFromEvents(_ values: NSSet)

}

// MARK: Generated accessors for tasks
extension Subject {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: Task)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: Task)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

extension Subject : Identifiable {

}
