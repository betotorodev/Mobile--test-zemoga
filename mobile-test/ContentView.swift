//
//  ContentView.swift
//  mobile-test
//
//  Created by Beto Toro on 19/11/22.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      List {
        ForEach(0..<5, id: \.self) { post in
          NavigationLink {
            Text("\(post + 1)")
          } label: {
            Text("post \(post + 1)")
          }
        }
      }
      .navigationTitle("Posts")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
