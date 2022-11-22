//
//  Favorites.swift
//  mobile-test
//
//  Created by Beto Toro on 21/11/22.
//

import Foundation

class Favorites: ObservableObject {
  private var posts: Set<String>
  
  private let saveKey = "Favorites"
  
  init() {
    if let data = UserDefaults.standard.data(forKey: saveKey) {
      if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
        posts = decoded
        return
      }
    }
    

    posts = []
  }
  

  func contains(_ post: Posts) -> Bool {
    posts.contains(String(post.id))
  }
  

  func add(_ post: Posts) {
    objectWillChange.send()
    posts.insert(String(post.id))
    save()
  }
  
  
  func remove(_ post: Posts) {
    objectWillChange.send()
    posts.remove(String(post.id))
    save()
  }
  
  func save() {
    if let encoded = try? JSONEncoder().encode(posts) {
      UserDefaults.standard.set(encoded, forKey: saveKey)
    }
  }
}
