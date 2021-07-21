//
//  PracticalCoreDataApp.swift
//  PracticalCoreData
//
//  Created by Russell Gordon on 2021-07-16.
//

import SwiftUI

@main
struct PracticalCoreDataApp: App {
    
    // Create an instance of our storage provider
    @StateObject private var storageProvider = StorageProvider()
    
    // DateFormatters to share across app
    @StateObject private var customDateFormatter = CustomDateFormatter()
    @StateObject private var verboseDateFormatter = VerboseDateFormatter()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                MovieListView()
            }
            // Insert storage provider into the environment
            .environmentObject(storageProvider)
            // Insert date formatters into the environment for later use
            .environmentObject(customDateFormatter)
            .environmentObject(verboseDateFormatter)
        }
    }
    
}
