//
//  Character+CoreDataProperties.swift
//  Character
//
//  Created by Russell Gordon on 2021-07-21.
//
//

import Foundation
import CoreData


extension Character {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Character> {
        return NSFetchRequest<Character>(entityName: "Character")
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

extension Character : Identifiable {

}
