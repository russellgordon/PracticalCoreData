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
    
    // Access DateFormatter
    @EnvironmentObject private var customDateFormatter: CustomDateFormatter

    // Whether this view should be showing or not
    @Binding var dismissView: Bool
    
    // The movie to edit
    @ObservedObject var movie: Movie
    
    // Range for release date
    var releaseDateOpenRange: PartialRangeFrom<Date> {
        let start = "01/01/1850"
        let startDate = customDateFormatter.date(from: start)!
        return startDate...
    }
    
    var body: some View {
        
        VStack {
            
            TextField("Enter movie name", text: $movie.name)
                .introspectTextField { textField in
                    
                    // Set focus to text field
                    textField.becomeFirstResponder()
                }
                .onSubmit {
                    updateMovie()
                }
            
            Stepper(value: $movie.duration, label: { Text("Run length in minutes: \(movie.duration)")})
            
            DatePicker("Release date: ", selection: $movie.releaseDate, in: releaseDateOpenRange, displayedComponents: .date)
            
            Toggle("Watched?", isOn: $movie.watched)
            
            Spacer()
            
        }
        .padding()
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
        
        let customDateFormatter = CustomDateFormatter()
        
        NavigationView {
            MovieEditView(dismissView: .constant(false),
                          movie: Movie.example)
        }
        .environmentObject(StorageProvider.preview)
        .environmentObject(customDateFormatter)
        
    }
}
