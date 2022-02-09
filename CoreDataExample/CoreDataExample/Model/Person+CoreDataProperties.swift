//
//  Person+CoreDataProperties.swift
//  CoreDataExample
//
//  Created by Nitin Bhatt on 2/7/22.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var address: String?

}

extension Person : Identifiable {

}
