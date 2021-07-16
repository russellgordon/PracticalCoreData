//
//  StorageProvider.swift
//  StorageProvider
//
//  Created by Russell Gordon on 2021-07-16.
//

import CoreData
import Foundation

class StorageProvider {
    
    // For initializing the Core Data stack and loading the Core Data model file
    let persistentContainer: NSPersistentContainer
    
    init() {
        
        // Access the model file
        persistentContainer = NSPersistentContainer(name: "PracticalCoreData")
        
        // Attempt to load persistent stores (the underlying storage of data)
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                
                // For now, any failure to load the model is a programming error, and not recoverable
                fatalError("Core Data store failed to load with error: \(error)")
            }
            
        }
    }
    
}

// Save a movie
extension StorageProvider {
    
    func saveMovie(named name: String) {
        
        // New Movie instance is tied to the managed object context
        let movie = Movie(context: persistentContainer.viewContext)
        
        // Set the name for the new movie
        movie.name = name
        
        do {
            
            // Persist the data in this managed object context to the underlying store
            try persistentContainer.viewContext.save()
            
            print("Movie saved successfully")
            
        } catch {
            
            // Something went wrong 😭
            print("Failed to save movie: \(error)")
            
            // Rollback any changes in the managed object context
            persistentContainer.viewContext.rollback()
            
        }
        
    }

}

// Get all the movies
extension StorageProvider {
    
    func getAllMovies() -> [Movie] {
        
        // Must specify the type with annotation, otherwise Xcode won't know what overload of fetchRequest() to use (we want to use the one for the Movie entity)
        // The generic argument <Movie> allows Swift to know what kind of managed object a fetch request returns, which will make it easier to return the list of movies as an array
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do {
            
            return try persistentContainer.viewContext.fetch(fetchRequest)
            
        } catch {
            
            print("Failed to fetch movies \(error)")
            
        }
        
        // If an error occured, return nothing
        return []
    }
    
}
