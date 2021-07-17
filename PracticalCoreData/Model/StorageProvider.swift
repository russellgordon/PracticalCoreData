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
    
    // For showing the list of movies
    @Published private(set) var movies: [Movie] = []
    
    init() {
        
        // Access the model file
        persistentContainer = NSPersistentContainer(name: "PracticalCoreData")
        
        // Attempt to load persistent stores (the underlying storage of data)
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                
                // For now, any failure to load the model is a programming error, and not recoverable
                fatalError("Core Data store failed to load with error: \(error)")
            } else {
                
                print("Successfully loaded persistent stores.")
                
                // Get all the movies
                self.movies = self.getAllMovies()
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
            
            // Refresh the list of movies
            movies = getAllMovies()
            
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
            
            // Refresh the list of movies
            movies = getAllMovies()
            
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
            // Tell SwiftUI that the list of movies is being modified
            objectWillChange.send()
            
            // Actually persist/save the changes to the managed object context
            try persistentContainer.viewContext.save()
            print("Movie updated.")
            
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context: \(error)")
        }
        
    }
    
}

// Get all the movies
extension StorageProvider {
    
    // Made private because views will access the movies retrieved from Core Data via the movies array in StorageProvider
    private func getAllMovies() -> [Movie] {
        
        // Must specify the type with annotation, otherwise Xcode won't know what overload of fetchRequest() to use (we want to use the one for the Movie entity)
        // The generic argument <Movie> allows Swift to know what kind of managed object a fetch request returns, which will make it easier to return the list of movies as an array
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do {
            
            // Return an array of Movie objects, retrieved from the Core Data store
            return try persistentContainer.viewContext.fetch(fetchRequest)
            
        } catch {
            
            print("Failed to fetch movies \(error)")
            
        }
        
        // If an error occured, return nothing
        return []
    }
    
}
