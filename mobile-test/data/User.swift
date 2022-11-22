//
//  User.swift
//  mobile-test
//
//  Created by Beto Toro on 21/11/22.
//

import Foundation

struct User: Codable {
  var name: String
  var username: String
  var email: String
  var website: String
  
  static let example = User(name: "Beto", username: "Beto Toro", email: "betotoro0902@gmail.com", website: "betotoro.info")
}
