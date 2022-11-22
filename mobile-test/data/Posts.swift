//
//  Posts.swift
//  mobile-test
//
//  Created by Beto Toro on 21/11/22.
//

import Foundation

struct Posts: Codable, Hashable {
  var userId: Int
  var id: Int
  var title: String
  var body: String
  static let saveKey = "Favorites"
  
  static let example = Posts(userId: 1, id: 1, title: "holi", body: "texto prueba")
}
