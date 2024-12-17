//
//  UserData+CoreDataProperties.swift
//  CoreDataPractise
//
//  Created by Amil Mammadov on 14.12.24.
//
//

import Foundation
import CoreData


extension UserData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserData> {
        return NSFetchRequest<UserData>(entityName: "UserData")
    }

    @NSManaged public var jobTitle: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var surname: String?
    @NSManaged public var username: String?

}

extension UserData : Identifiable {

}
