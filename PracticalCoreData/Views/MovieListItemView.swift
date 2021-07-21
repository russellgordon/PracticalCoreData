//
//  MovieListItemView.swift
//  MovieListItemView
//
//  Created by Russell Gordon on 2021-07-21.
//

import SwiftUI

struct MovieListItemView: View {
    
    let movie: Movie
    
    // Access DateFormatter
    @EnvironmentObject private var customDateFormatter: CustomDateFormatter
    
    var body: some View {
        HStack {
            Image(systemName: movie.watched ? "rectangle.badge.checkmark" : "rectangle")
            
            VStack(alignment: .leading) {
                Text(movie.name)
                Text("Released: \(customDateFormatter.string(from: movie.releaseDate)), \(movie.duration) minutes")
                    .font(.caption)
            }
        }
    }
}

struct MovieListItemView_Previews: PreviewProvider {
    static var previews: some View {
        
        let customDateFormatter = CustomDateFormatter()
        
        MovieListItemView(movie: Movie.example)
            .environmentObject(customDateFormatter)

    }
}
