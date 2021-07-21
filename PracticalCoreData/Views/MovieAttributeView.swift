//
//  MovieAttributeView.swift
//  MovieAttributeView
//
//  Created by Russell Gordon on 2021-07-21.
//

import SwiftUI

struct MovieAttributeView: View {
    
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .font(.subheadline)
                .bold()
                .padding(.vertical, 3)
            
            Text(value)
        }
    }
}

struct MovieAttributeView_Previews: PreviewProvider {
    static var previews: some View {
        MovieAttributeView(label: "Released", value: "February 21, 1977")
    }
}
