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
    
    // Access DateFormatter
    @EnvironmentObject private var customDateFormatter: CustomDateFormatter

    // Whether to show add movie interface
    @State private var showAddMovie = false
    
    enum Field {
        case name
        case duration
        case releaseDate
        case watched
    }
    
    // Range for release date
    var releaseDateOpenRange: PartialRangeFrom<Date> {
        let start = "01/01/1850"
        let startDate = customDateFormatter.date(from: start)!
        return startDate...
    }
    
    // Fields to enter movie name into
    @State private var movieName = ""
    @State private var movieDuration = 120
    @State private var movieReleaseDate = Date()
    @State private var movieWatched = false
    
    // What field has the focus
    @FocusState private var focusedField: Field?
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            // Empty view seems to be necessary to get SwiftUI to draw the surrounding VStack
            Text("")
            
            // Interface for adding a movie
            if showAddMovie {
                
                VStack {
                    
                    TextField("Enter movie name", text: $movieName)
                        .introspectTextField { textField in
                            
                            // Set focus to the text field
                            textField.becomeFirstResponder()
                            
                        }
                        .focused($focusedField, equals: .name)
                        .submitLabel(.next)
                        // This modifier is invoked when the user presses Return
                        .onSubmit {
                            saveMovie()
                        }
                    
                    Stepper(value: $movieDuration, label: { Text("Run length in minutes: \(movieDuration)")})
                    
                    DatePicker("Release date: ", selection: $movieReleaseDate, in: releaseDateOpenRange, displayedComponents: .date)
                    
                    Toggle("Watched?", isOn: $movieWatched)
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            saveMovie()
                        }) {
                            Text("Add")
                        }
                        .keyboardShortcut(.defaultAction)
                        
                    }
                    .padding(.top)
                    
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            
            // List to show the movies added
            List {
                // NOTE: Must use the ForEach with an identifiable collection (or id: \.self) to use .swipeActions
                ForEach(storageProvider.movies) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MovieListItemView(movie: movie)
                    }
                    .swipeActions(allowsFullSwipe: true) {
                        
                        // Delete this set of dice
                        Button(role: .destructive, action: {
                            
                            print("About to delete movie...")
                            
                            withAnimation {
                                // Attempt to delete the movie
                                storageProvider.deleteMovie(movie)
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
                    focusedField = .name
                }
            }
            
        }
    }
    
    func saveMovie() {
        // Saving movie
        print("About to save movie...")
        
        // Save the movie
        storageProvider.saveMovie(named: movieName,
                                  duration: movieDuration,
                                  releasedOn: movieReleaseDate,
                                  watched: movieWatched)

        // Clear input field
        movieName = ""
        movieDuration = 120
        movieReleaseDate = Date()
        movieWatched = false
        
        // Set focus back to the input field
        focusedField = .name
    }
}

struct MovieListView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let customDateFormatter = CustomDateFormatter()
        
        NavigationView {
            MovieListView()
        }
        .environmentObject(StorageProvider.preview)
        .environmentObject(customDateFormatter)

    }
    
}
