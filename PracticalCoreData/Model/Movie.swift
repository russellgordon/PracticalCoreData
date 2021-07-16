//
//  Movie.swift
//  Movie
//
//  Created by Russell Gordon on 2021-07-16.
//

import CoreData
import Foundation
import SwiftUI

// Return a fetch request that gets us all the movies
extension Movie {

    // Must specify the type with annotation, otherwise Xcode won't know what overload of fetchRequest() to use (we want to use the one for the Movie entity)
    // The generic argument <Movie> allows Swift to know what kind of managed object a fetch request returns, which will make it easier to return the list of movies as an array
    static var allMovies: FetchRequest<Movie> = {

        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        // Set sort descriptors
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Movie.name, ascending: true)
        ]
        
        // Set predicates for filtering
        request.predicate = nil

        return FetchRequest(fetchRequest: request)

    }()


}
