//
//  StorageProvider.swift
//  StorageProvider
//
//  Created by Russell Gordon on 2021-07-16.
//

import CoreData
import Foundation

// Must conform to ObservableObject to be passed through the environment
class StorageProvider: ObservableObject {
    
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

// Delete a movie
extension StorageProvider {
    
    func deleteMovie( _ movie: Movie) {
        
        persistentContainer.viewContext.delete(movie)
        
        do {
            
            try persistentContainer.viewContext.save()
            
            print("Movie deleted.")
            
        } catch {
            
            persistentContainer.viewContext.rollback()
            print("Failed to save context: \(error)")
            
        }
        
    }
    
}

// Update a movie
extension StorageProvider {
    
    func updateMovies() {
        
        do {
            try persistentContainer.viewContext.save()
            print("Movie updated.")
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context: \(error)")
        }
        
    }
    
}
