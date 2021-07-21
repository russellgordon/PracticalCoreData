//
//  Movie+CoreDataProperties.swift
//  Movie
//
//  Created by Russell Gordon on 2021-07-21.
//
//

import Foundation
import CoreData


extension Movie {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }
    
    @NSManaged public var rawDuration: Int64
    @NSManaged public var rawRating: Double
    @NSManaged public var rawReleaseDate: Date?
    @NSManaged public var rawTitle: String?
    @NSManaged public var rawWatched: Bool
    @NSManaged public var rawPosterImage: NSObject?
    
    public var duration: Int {
        get {
            Int(rawDuration)
        }
        
        set(newDuration) {
            rawDuration = Int64(newDuration)
        }
    }
    
    public var rating: Double {
        get {
            rawRating
        }
        
        set(newRating) {
            rawRating = newRating
        }
    }

    // Wrap the optionality of the rawDate attribute to simplify use in SwiftUI views
    public var releaseDate: Date {
        get {
            rawReleaseDate ?? Date()
        }
        
        set(newDate) {
            rawReleaseDate = newDate
        }
    }
    
    // Wrap the optionality of the rawTitle attribute to simplify use in SwiftUI views
    public var name: String {
        get {
            rawTitle ?? ""
        }
        
        set(newName) {
            rawTitle = newName
        }
    }
    
    public var watched: Bool {
        get {
            rawWatched
        }
        
        set (newWatched) {
            rawWatched = newWatched
        }
    }
    
    
}

extension Movie : Identifiable {
    
}
