//
//  MovieListView.swift
//  PracticalCoreData
//
//  Created by Russell Gordon on 2021-07-16.
//

import Introspect
import SwiftUI

struct MovieListView: View {
    
    // Access StorageProvider instance
    @EnvironmentObject private var storageProvider: StorageProvider
    
    // Whether to show add movie interface
    @State private var showAddMovie = false
    
    // Field to enter movie name into
    @State private var movieName = ""
    @FocusState private var isFocused: Bool
    
    // The list of movies to show
    @State private var movies: [Movie] = []
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("")

            // Interface for adding a movie
            if showAddMovie {
                
                VStack {
                    HStack {
                        
                        TextField("Enter movie name", text: $movieName)
                            .introspectTextField { textField in
                                
                                // Set focus to the text field
                                textField.becomeFirstResponder()
                                                                
                            }
                            .focused($isFocused)
                            // This modifier is invoked when the user presses Return
                            .onSubmit {
                                saveMovie()
                            }

                        
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
                ForEach(movies) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)
                                    .environmentObject(storageProvider)) {
                        Text(movie.name)
                    }
                    .swipeActions(allowsFullSwipe: true) {
                        
                        // Delete this set of dice
                        Button(role: .destructive, action: {
                            
                            print("About to delete movie...")

                            withAnimation {
                                // Attempt to delete the movie
                                storageProvider.deleteMovie(movie)
                                
                                // Update the list of movies
                                movies = storageProvider.getAllMovies()
                            }

                        }) {
                            Label("Delete", systemImage: "trash.fill")
                        }
                                                        
                    }

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

                    // NOTE: This doesn't seem to work to set the focus to the TextField 🤨
                    //       Really wish it would...
                    isFocused = true
                }
            }
            
        }
        .onAppear {
            // Load the list of movies
            movies = storageProvider.getAllMovies()
        }

    }
    
    func saveMovie() {
        // Saving movie
        print("About to save movie...")
        
        // Save the movie
        storageProvider.saveMovie(named: movieName)
        
        // Update the list of movies
        movies = storageProvider.getAllMovies()
        
        // Clear input field
        movieName = ""
        
        // Set focus back to the input field
        isFocused = true
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
