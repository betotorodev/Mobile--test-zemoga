//
//  Comments.swift
//  mobile-test
//
//  Created by Beto Toro on 21/11/22.
//

import Foundation

struct Comments: Codable {
  var id: Int
  var name: String
  var email: String
  var body: String
  
  static let example = [
    Comments(id: 1, name: "tiby",email: "ejemplo@gamil.com", body: "texto ejemplo"),
    Comments(id: 2, name: "toño",email: "ejemplo@gamil.com", body: "texto ejemplo"),
    Comments(id: 3, name: "aleja",email: "ejemplo@gamil.com", body: "texto ejemplo"),
    Comments(id: 4, name: "manu",email: "ejemplo@gamil.com", body: "texto ejemplo")
  ]
}
