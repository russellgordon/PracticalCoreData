//
//  ContentView.swift
//  PracticalCoreData
//
//  Created by Russell Gordon on 2021-07-16.
//

import SwiftUI

struct ContentView: View {
    
    // Access StorageProvider instance by dependency injection
    // (the view depends on the instance of StorageProvider passed by its creator)
    // NOTE: Wondering whether inserting into the environment and accessing via @EnvironmentObject might be an alternative in the future
    let storageProvider: StorageProvider
    
    // Whether to show add movie interface
    @State private var showAddMovie = false
    
    // Field to enter movie name into
    @State private var movieName = ""
    @FocusState private var isFocused: Bool
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("")

            // Interface for adding a movie
            if showAddMovie {
                
                VStack {
                    HStack {
                        
                        TextField("Enter movie name", text: $movieName)
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
                Text("Movie 1")
                Text("Movie 2")
                Text("Movie 3")
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
    }
    
    func saveMovie() {
        // Saving movie
        print("About to save movie...")
        
        // Clear input field
        movieName = ""
        
        // Set focus back to the input field
        isFocused = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(storageProvider: StorageProvider())
    }
}
