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
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(storageProvider: StorageProvider())
    }
}
