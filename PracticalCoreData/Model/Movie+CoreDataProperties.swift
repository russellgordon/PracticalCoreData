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

extension Movie : Identifiable {

}
