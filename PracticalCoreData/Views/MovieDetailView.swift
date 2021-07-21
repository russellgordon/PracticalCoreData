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
    
    // Access DateFormatter
    @EnvironmentObject private var verboseDateFormatter: VerboseDateFormatter
    
    // Whether to show the edit sheet
    @State private var showEditSheet = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                MovieAttributeView(label: "Released",
                                   value: verboseDateFormatter.string(from: movie.releaseDate))
                
                MovieAttributeView(label: "Runs",
                                   value: "\(movie.duration) minutes")

                MovieAttributeView(label: "Watched it?",
                                   value: movie.watched ? "Yep" : "Nope")

                // Force the VStack to be the maximum width
                HStack{
                    Spacer()
                }
            }
//            .background(Color.blue)
            .padding(.horizontal)
        }
        .navigationTitle(movie.name)
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
        
        let verboseDateFormatter = VerboseDateFormatter()

        NavigationView {
            MovieDetailView(movie: Movie.example)
        }
        .environmentObject(StorageProvider.preview)
        .environmentObject(verboseDateFormatter)

    }
    
}
