//
//  PostDetail.swift
//  mobile-test
//
//  Created by Beto Toro on 19/11/22.
//

import SwiftUI

struct PostDetail: View {
  let post: Posts
  @State private var userInfo = User.example
  @State private var comments = [Comments]()
  
  func loadData() async {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/users/\(post.userId)") else {
      print("Invalid URL")
      return
    }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      if let decodedResponse = try? JSONDecoder().decode(User.self, from: data) {
        userInfo = decodedResponse
      }
    } catch {
      print("Invalid data")
    }
  }
  
  func loadComments() async {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(post.id)/comments") else {
      print("Invalid URL")
      return
    }
    do {
      let (data, _) = try await URLSession.shared.data(from: url)
      if let decodedResponse = try? JSONDecoder().decode([Comments].self, from: data) {
        comments = decodedResponse
      }
    } catch {
      print("Invalid data")
    }
  }
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("\(post.title)")
      Text("\(post.body)")
      Text("\(userInfo.name)")
      
      List {
        ForEach(comments, id: \.id) { comment in
          Text("holi \(post.id) \(comment.name)")
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .navigationTitle("\(post.title)")
    .navigationBarTitleDisplayMode(.inline)
    .task {
      await loadData()
      await loadComments()
    }
  }
}

struct PostDetail_Previews: PreviewProvider {
  static var previews: some View {
    PostDetail(post: Posts.example)
  }
}
