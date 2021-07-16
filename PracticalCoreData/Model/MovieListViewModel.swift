//
//  MovieListViewModel.swift
//  MovieListViewModel
//
//  Created by Russell Gordon on 2021-07-16.
//

import Foundation
import CoreData

class MovieListViewModel: NSObject, ObservableObject {
    
    @Published var movies: [Movie] = []
    
    private let fetchedResultsController: NSFetchedResultsController<Movie>
    
    init(storageProvider: StorageProvider) {
        
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        // Set sort descriptors
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Movie.rawName, ascending: true)
        ]
        
        // Set predicates for filtering
        request.predicate = nil

        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request,
                                                                   managedObjectContext: storageProvider.persistentContainer.viewContext,
                                                                   sectionNameKeyPath: nil,
                                                                   cacheName: nil)
        
        super.init()
        
        fetchedResultsController.delegate = self
        
        try! fetchedResultsController.performFetch()
        
        // Set the list of movies if any were fetched, otherwise, list of movies is empty
        movies = fetchedResultsController.fetchedObjects ?? []
        
    }
}

extension MovieListViewModel: NSFetchedResultsControllerDelegate {
    
    // Ensure the list of movies gets updated in the UI
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        movies = controller.fetchedObjects as? [Movie] ?? []
    }
    
}
