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
  @State private var comments = Comments.example
  
  func loadData() async {
    guard let urlUsers = URL(string: "https://jsonplaceholder.typicode.com/users/\(post.userId)") else {
      print("Invalid URL")
      return
    }
    guard let urlComments = URL(string: "https://jsonplaceholder.typicode.com/posts/\(post.id)/comments") else {
      print("Invalid URL")
      return
    }

    do {
      let (dataUser, _) = try await URLSession.shared.data(from: urlUsers)
      if let decodedResponse = try? JSONDecoder().decode(User.self, from: dataUser) {
        userInfo = decodedResponse
      }
      
      let (dataComments, _) = try await URLSession.shared.data(from: urlComments)
      if let decodedResponse = try? JSONDecoder().decode([Comments].self, from: dataComments) {
        comments = decodedResponse
      }
    } catch {
      print("Invalid data")
    }
  }
  
  var body: some View {
    VStack {
      List {
        Section("Post") {
          VStack(alignment: .leading) {
            Text("\(post.title)")
              .font(.title)
              .bold()
              .padding(.bottom, 2)
            Text("\(post.body)")
              .foregroundColor(.gray)
          }
          HStack {
            VStack(alignment: .leading) {
              Text("Written by: \(userInfo.name)")
                .padding(.bottom, 2)
              Group {
                Text("Bitter: @\(userInfo.username)")
                Text("Email: \(userInfo.email)")
                Text("Website: \(userInfo.website)")
              }
              .font(.caption)
              .foregroundColor(.secondary)
            }
            Spacer()
          }
          .frame(maxWidth: .infinity)
        }
        
        Section("Comments") {
          ForEach(comments, id: \.id) { comment in
            VStack(alignment: .leading) {
              Text("\(comment.name)")
                .font(.callout)
                .bold()
                .foregroundColor(.secondary)
              Text("\(comment.email)")
                .font(.caption)
                .bold()
                .foregroundColor(.secondary)
                .padding(.bottom, 2)
              Text("\(comment.body)")
            }
          }
        }
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .navigationTitle("\(userInfo.name)")
    .navigationBarTitleDisplayMode(.inline)
    .task {
      await loadData()
    }
  }
}

struct PostDetail_Previews: PreviewProvider {
  static var previews: some View {
    PostDetail(post: Posts.example)
  }
}
