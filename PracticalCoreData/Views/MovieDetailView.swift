//
//  MovieDetailView.swift
//  MovieDetailView
//
//  Created by Russell Gordon on 2021-07-16.
//

import SwiftUI

struct MovieDetailView: View {

    let movie: Movie
    
    var body: some View {
        Text("\(movie.name ?? "")")
            .navigationTitle("Detail")
    }
    
}

//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView()
//    }
//}
