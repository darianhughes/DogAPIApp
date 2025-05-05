//
//  FavoritesView.swift
//  DogAPIApp
//
//  Created by HUGHES, DARIAN M. on 5/5/25.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favorites: FavoritesManager
    
    let columns: [GridItem(.adaptive(minimum: 100), spacing: 16)]
    
    var body: some View {
        NavigationView {
            if favorites.items.isEmpty {
                Text("No favorites yet!")
                    .foregroundColor(.secondary)
                    .navigationTitle(Text("Favorites"))
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(favorites.items, id: \.self) { url in
                            NavigationLink(destination: DogDetailView(imageUrl: url)) {
                                AsyncImage(url: URL(string: url)) { image in
                                    image.resizable().scaledToFill()
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }
                                .frame(height: 100)
                                .clipped()
                                .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle(Text("Favorites"))
            }
        }
    }
}
