//
//  FavoritesManager.swift
//  DogAPIApp
//
//  Created by HUGHES, DARIAN M. on 5/5/25.
//

import Foundation
import Combine

class FavoritesManager : ObservableObject {
    @Published private(set) var items: [String] = []
    
    private let key = "favoriteDogImages"
    
    init() {
        if let saved = UserDefaults.standard.stringArray(forKey: key) {
            self.items = saved
        }
    }
    
    func toggle(_ url:String) {
        if let idx = items.firstIndex(of: url) {
            items.remove(at: idx)
        } else {
            items.append(url)
        }
        UserDefaults.standard.set(items, forKey: key)
    }
    
    func contains(_ url:String) -> Bool {
        items.contains(url)
    }
}
