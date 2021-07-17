//
//  MovieEditView.swift
//  MovieEditView
//
//  Created by Russell Gordon on 2021-07-16.
//

import SwiftUI

struct MovieEditView: View {
    
    // Access StorageProvider instance
    @EnvironmentObject private var storageProvider: StorageProvider

    // Whether this view should be showing or not
    @Binding var dismissView: Bool
    
    // The movie to edit
    @ObservedObject var movie: Movie
        
    var body: some View {
        
        Form {
            TextField("Enter movie name", text: $movie.name)
                .introspectTextField { textField in
                    
                    // Set focus to text field
                    textField.becomeFirstResponder()
                    
                    // When the text field gets the focus, select the text; this saves the user having to select the text before typing a new word
                    // NOTE: If statement exists to work around issue where first character of input given to an empty text field gets auto-selected again; with this conditional the text is selected only when the textfield has more than a single character
                    if textField.text?.count ?? 0 > 1 {
                        textField.selectAll(nil)
                    }

                }
                .onSubmit {
                    updateMovie()
                }
        }
        .navigationTitle("Edit movie")
        .toolbar {
            
            ToolbarItem(placement: .confirmationAction) {
                Button("Done") {
                    updateMovie()
                }
            }
        }

    }
    
    func updateMovie() {
        print("About to update movie...")
                            
        // Save the changes in the persistent store
        storageProvider.updateMovies()
        
        // Dismiss this view
        dismissView.toggle()
    }
    
}

struct MovieEditView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            MovieEditView(dismissView: .constant(false),
                          movie: Movie.example)
                .environmentObject(StorageProvider.preview)
        }
        
    }
}
