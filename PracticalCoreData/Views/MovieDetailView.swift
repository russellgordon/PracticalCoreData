//
//  MovieDetailView.swift
//  MovieDetailView
//
//  Created by Russell Gordon on 2021-07-16.
//

import SwiftUI

struct MovieDetailView: View {
    
    // The movie whose details we are viewing
    @ObservedObject var movie: Movie
    
    // Whether to show the edit sheet
    @State private var showEditSheet = false
    
    var body: some View {
        Text(movie.name)
            .navigationTitle("Detail")
            .sheet(isPresented: $showEditSheet) {
                NavigationView {
                    MovieEditView(dismissView: $showEditSheet, movie: movie)
                }
            }
            .toolbar {
                
                Button(action: {
                    showEditSheet = true
                }) {
                    Text("Edit")
                }
                
            }
        
    }
    
}

struct MovieDetailView_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationView {
            MovieDetailView(movie: Movie.example)
        }
        .environmentObject(StorageProvider.preview)
    }
    
}
