//
//  PracticalCoreDataApp.swift
//  PracticalCoreData
//
//  Created by Russell Gordon on 2021-07-16.
//

import SwiftUI

@main
struct PracticalCoreDataApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                MovieListView(storageProvider: StorageProvider())
            }
        }
    }
}
