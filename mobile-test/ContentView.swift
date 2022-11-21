//
//  ContentView.swift
//  mobile-test
//
//  Created by Beto Toro on 19/11/22.
//

import SwiftUI

struct Response: Codable {
  var userId: Int
  var id: Int
  var title: String
  var body: String
  
  static let example = Response(userId: 1, id: 1, title: "holi", body: "texto prueba")
}

struct ContentView: View {
  
  @State private var results = [Response]()
  
  func loadData() async {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
      print("Invalid URL")
      return
    }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      if let decodedResponse = try? JSONDecoder().decode([Response].self, from: data) {
        results = decodedResponse
      }
    } catch {
      print("Invalid data")
    }
  }
  
  var body: some View {
    NavigationView {
      List {
        ForEach(results, id: \.id) { post in
          NavigationLink {
            PostDetail(post: post)
          } label: {
            HStack {
              Image(systemName: "star")
                .font(.callout)
              Text("\(post.title)")
            }
          }
        }
      }
      .navigationTitle("Posts")
      .task {
        await loadData()
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
