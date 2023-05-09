//
//  Quote+CoreDataProperties.swift
//  3178-Assignment
//
//  Created by Anika Kamleshwaran on 9/5/2023.
//
//

import Foundation
import CoreData


extension Quote {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quote> {
        return NSFetchRequest<Quote>(entityName: "Quote")
    }

    @NSManaged public var quote: String?
    @NSManaged public var author: String?

}

extension Quote : Identifiable {

}
