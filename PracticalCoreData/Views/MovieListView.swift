//
//  MovieListView.swift
//  PracticalCoreData
//
//  Created by Russell Gordon on 2021-07-16.
//

import SwiftUI

struct MovieListView: View {
    
    // Access StorageProvider instance
    @EnvironmentObject private var storageProvider: StorageProvider
    
    // Whether to show add movie interface
    @State private var showAddMovie = false
    
    // Field to enter movie name into
    @State private var movieName = ""
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            // Empty view seems to be necessary to get SwiftUI to draw the surrounding VStack
            Text("")

            // Interface for adding a movie
            if showAddMovie {
                
                VStack {
                    HStack {
                        
                        TextField("Enter movie name", text: $movieName)
                        
                        Button(action: {
                            saveMovie()
                        }) {
                            Text("Add")
                        }
                        .keyboardShortcut(.defaultAction)

                    }
                    
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            
            // List to show the movies added
            List {
                // NOTE: Must use the ForEach with an identifiable collection (or id: \.self) to use .swipeActions
                ForEach(storageProvider.movies) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)
                                    .environmentObject(storageProvider)) {
                        Text(movie.name)
                    }

                }
                .onDelete { indexSet in
                    print("About to delete a movie...")
                    storageProvider.deleteMovies(at: indexSet)
                }
            }
            // This modifier seems to be necessary to force SwiftUI to add a gap between the header and the list
            // The background won't actually be red, but a clear background doesn't work
            .background(Color.red)

            
        }
        .navigationTitle("Core Data")
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Button(showAddMovie ? "Done" : "New") {
                    showAddMovie.toggle()
                }
            }
            
        }
    }
    
    func saveMovie() {
        // Saving movie
        print("About to save movie...")
        
        // Save the movie
        storageProvider.saveMovie(named: movieName)
        
        // Clear input field
        movieName = ""
    }
}

struct MovieListView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        NavigationView {
            MovieListView()
                .environmentObject(StorageProvider.preview)
        }
        
    }
    
}
