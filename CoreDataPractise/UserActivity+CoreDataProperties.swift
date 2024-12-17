//
//  UserActivity+CoreDataProperties.swift
//  CoreDataPractise
//
//  Created by Amil Mammadov on 15.12.24.
//
//

import Foundation
import CoreData


extension UserActivity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserActivity> {
        return NSFetchRequest<UserActivity>(entityName: "UserActivity")
    }

    @NSManaged public var activity: String?
    @NSManaged public var id: Int16

}

extension UserActivity : Identifiable {

}
