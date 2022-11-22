//
//  Favorites.swift
//  mobile-test
//
//  Created by Beto Toro on 21/11/22.
//

import Foundation

class Favorites: ObservableObject {
  // the actual posts the user has favorited
  private var posts: Set<String>
  
  // the key we're using to read/write in UserDefaults
  private let saveKey = "Favorites"
  
  init() {
    // load our saved data
    if let data = UserDefaults.standard.data(forKey: saveKey) {
      if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
        posts = decoded
        return
      }
    }
    
    // still here? Use an empty array
    posts = []
  }
  
  // returns true if our set contains this resort
  func contains(_ post: Posts) -> Bool {
    posts.contains(String(post.id))
  }
  
  // adds the resort to our set, updates all views, and saves the change
  func add(_ post: Posts) {
    objectWillChange.send()
    posts.insert(String(post.id))
    save()
  }
  
  // removes the resort from our set, updates all views, and saves the change
  func remove(_ post: Posts) {
    objectWillChange.send()
    posts.remove(String(post.id))
    save()
  }
  
  func save() {
    // write out our data
    if let encoded = try? JSONEncoder().encode(posts) {
      UserDefaults.standard.set(encoded, forKey: saveKey)
    }
  }
}
