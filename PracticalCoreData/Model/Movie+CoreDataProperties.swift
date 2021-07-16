//
//  Movie+CoreDataProperties.swift
//  Movie
//
//  Created by Russell Gordon on 2021-07-16.
//
//

import Foundation
import CoreData

extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var rawName: String?
    
    // Handle the optionality of the rawName attribute
    public var name: String {
        get {
            rawName ?? ""
        }
        
        set(newName) {
            rawName = newName
        }
    }

}

extension Movie : Identifiable {

}
