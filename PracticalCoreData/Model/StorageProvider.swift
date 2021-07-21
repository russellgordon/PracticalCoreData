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
    
    // For showing the list of movies
    @Published private(set) var movies: [Movie] = []
    
    // For initializing the Core Data stack and loading the Core Data model file
    let persistentContainer: NSPersistentContainer
    
    // For use with Xcode Previews, provides some data to work with for examples
    static var preview: StorageProvider = {
        
        // Create an instance of the provider that runs in memory only
        let storageProvider = StorageProvider(inMemory: true)
        
        // Add a few test movies
        let movies = [
            ["name": "The Godfather",
             "duration": 177,
             "releaseDate": "14/03/1972",
             "watched": false],
            ["name": "The Shawshank Redemption",
             "duration": 142,
             "releaseDate": "10/09/1994",
             "watched": true],
            ["name": "Schindler's List",
             "duration": 195,
             "releaseDate": "30/11/1993",
             "watched": true],
            ["name": "Raging Bull",
             "duration": 129,
             "releaseDate": "14/11/1980",
             "watched": false],
            ["name": "Casablanca",
             "duration": 102,
             "releaseDate": "26/11/1942",
             "watched": true],
            ["name": "Citizen Kane",
             "duration": 119,
             "releaseDate": "01/05/1941",
             "watched": false],
        ]
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        for movie in movies {
            let releaseDate = movie["releaseDate"] as! String
            storageProvider.saveMovie(named: movie["name"] as! String,
                                      duration: movie["duration"] as! Int,
                                      releasedOn: formatter.date(from: releaseDate)!,
                                      watched: movie["watched"] as! Bool)
        }
        
        // Now save these movies (remember though, these go to the in-memory-only Core Data store)
        do {
            try storageProvider.persistentContainer.viewContext.save()
        } catch {
            // Something went wrong 😭
            print("Failed to save test movies: \(error)")
            
        }
        
        return storageProvider
    }()
    
    
    init(inMemory: Bool = false) {
        
        // Set value transformer for the movie posetr image
        ValueTransformer.setValueTransformer(UIImageTransformer(), forName: NSValueTransformerName(rawValue: "UIImageTransformer"))
        
        // Access the model file
        persistentContainer = NSPersistentContainer(name: "PCDChapter3")
        
        // Don't save information for future use if running in memory...
        if inMemory {
            persistentContainer.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
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
    
    func saveMovie(named name: String,
                   duration: Int,
                   releasedOn releaseDate: Date,
                   watched: Bool) {
        
        // New Movie instance is tied to the managed object context
        let movie = Movie(context: persistentContainer.viewContext)
        
        // Set the name for the new movie
        movie.name = name
        movie.duration = duration
        movie.releaseDate = releaseDate
        movie.watched = watched
        
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
