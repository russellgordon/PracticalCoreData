//
//  Actor+CoreDataProperties.swift
//  Actor
//
//  Created by Russell Gordon on 2021-07-21.
//
//

import Foundation
import CoreData


extension Actor {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Actor> {
        return NSFetchRequest<Actor>(entityName: "Actor")
    }

    @NSManaged public var rawName: String?
    
    // Wrap the optionality of the rawName attribute to simplify use in SwiftUI views
    public var name: String {
        get {
            rawName ?? ""
        }
        
        set(newName) {
            rawName = newName
        }
    }
    
}

extension Actor : Identifiable {

}
