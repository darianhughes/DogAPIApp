//
//  DogBrowserView.swift
//  DogAPIApp
//
//  Created by HUGHES, DARIAN M. on 5/5/25.
//

import SwiftUI

struct DogBrowserView: View {
    @State private var images: [String] = []
    @State private var breedInput: String = ""
    @State private var loading = false
    @EnvironmentObject var favorites: FavoritesManager
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter breed (e.g. husky)", text: $breedInput)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Button("Search") {
                        loadBreed()
                    }
                    .disabled(breedInput.isEmpty)
                }
                .padding()
                
                if loading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(images, id: \.self) { url in
                        NavigationLink(destination: DogDetailView(imageUrl: url)) {
                            HStack {
                                AsyncImage(url: URL(string: url)) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                } placeholder: {
                                    Color.gray.opacity(0.3)
                                }
                                /
                                .frame(width: 80, height: 80)
                                .cornerRadius(8)
                                Text(url.components(separatedBy: "/")[4].capitalized)
                                    .lineLimit(1)
                                Spacer()
                                if favorites.contains(url) {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Browse Dogs")
            .onAppear(perform: loadRandom)
        }
    }
    
    private func loadRandom() {
        loading = true
        DogAPI.fetchRandomImages { result in
            DispatchQueue.main.async {
                loading = false
                switch result {
                case .success(let imgs): self.images = imgs
                case .failure: self.images = []
                }
            }
        }
    }
    
    private func loadBreed() {
        loading = true
        DogAPI.fetchBreedImages(breed: breedInput) { result in
                DispatchQueue.main.async {
                loading = false
                switch result {
                case .success(let imgs): self.images = imgs
                case .failure: self.images = []
                }
            }
        }
    }
}
