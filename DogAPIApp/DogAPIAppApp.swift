//
//  DogAPIAppApp.swift
//  DogAPIApp
//
//  Created by HUGHES, DARIAN M. on 5/5/25.
//

import SwiftUI

@main
struct DogAPIAppApp: App {
    @StateObject private var favorites = FavoritesManager()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                DogBrowserView()
                    .tabItem {
                        Label("Browse", systemImage: "photo.on.rectangle.angled")
                    }
                
                FavoritesView()
                    .tabItem {
                        Label("Favorites", systemImage: "heart")
                    }
            }
        }
    }
}
