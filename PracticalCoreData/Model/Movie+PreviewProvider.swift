//
//  Movie+PreviewProvider.swift
//  Movie+PreviewProvider
//
//  Created by Russell Gordon on 2021-07-17.
//

import CoreData
import Foundation

// Exists to provide a movie to use with MovieDetailView and MovieEditView
extension Movie {
    
    // Example movie for Xcode previews
    static var example: Movie {
        
        // Get the first movie from the in-memory Core Data store
        let context = StorageProvider.preview.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        fetchRequest.fetchLimit = 1
        
        let results = try? context.fetch(fetchRequest)
        
        return (results?.first!)!
    }
    
}
