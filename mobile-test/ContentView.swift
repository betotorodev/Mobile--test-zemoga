//
//  ContentView.swift
//  mobile-test
//
//  Created by Beto Toro on 19/11/22.
//

import SwiftUI

struct ContentView: View {
  
  @State private var posts = [Posts]()
  @StateObject var favorites = Favorites()
  
  func loadData() async {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
      print("Invalid URL")
      return
    }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      if let decodedResponse = try? JSONDecoder().decode([Posts].self, from: data) {
        posts = decodedResponse
      }
    } catch {
      print("Invalid data")
    }
  }
  
  func removePost(at offsets: IndexSet) {
    posts.remove(atOffsets: offsets)
  }
  
  var body: some View {
    NavigationView {
      List {
        ForEach(posts, id: \.id) { post in
          NavigationLink {
            PostDetail(post: post)
          } label: {
            HStack {
              Image(systemName: "\(favorites.contains(post) ? "star.fill": "star")")
                .font(.title3)
                .onTapGesture {
                  if favorites.contains(post) {
                    favorites.remove(post)
                  } else {
                    favorites.add(post)
                  }
                }
                .padding(5)
              VStack(alignment: .leading) {
                Text("title")
                  .font(.caption)
                  .foregroundColor(.secondary)
                  .padding(.bottom, 1)
                Text("\(post.title)")
                  .font(.subheadline)
              }
            }
          }
        }
        .onDelete(perform: removePost)
      }
      .navigationTitle("Posts")
      .toolbar {
        EditButton()
      }
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
