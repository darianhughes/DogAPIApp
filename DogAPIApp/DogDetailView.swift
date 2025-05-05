//
//  DogDetailView.swift
//  DogAPIApp
//
//  Created by HUGHES, DARIAN M. on 5/5/25.
//

import SwiftUI

struct DogDetailView: View {
    let imageURL: String
    @EnvironmentObject var favorites: FavoritesManager
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: imageURL)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .padding()
            
            Button(action: { favorites.toggle(imageURL: imageURL)}) {
                Label(
                    favorites.contains(imageURL) ? "Unfavorite" : "Favorite",
                    system: favorites.contains(imageURL) ? "heart.fill" : "heart"
                )
                .padding()
                .background(Color.blue.opacity(0.2))
                .cornerRadius(8)
            }
            
            Spacer()
        }
        .navigationTitle("Dog")
        .navigationBarTitleDisplayMode(.inline)
    }
}
