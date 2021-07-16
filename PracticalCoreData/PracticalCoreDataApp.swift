//
//  PracticalCoreDataApp.swift
//  PracticalCoreData
//
//  Created by Russell Gordon on 2021-07-16.
//

import SwiftUI

@main
struct PracticalCoreDataApp: App {
    
    @StateObject private var storageProvider = StorageProvider()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MovieListView()
                    // Insert storage provider into the environment
                    .environmentObject(storageProvider)
            }
        }
    }
}
