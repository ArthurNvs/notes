//
//  CreditsView.swift
//  Notes WatchKit Extension
//
//  Created by Arthur Neves on 09/12/21.
//

import SwiftUI

struct CreditsView: View {
  @State private var randomNumber: Int = Int.random(in: 1..<4)
  
  private var randomImage: String {
    return "developer-no\(randomNumber)"
  }
  var body: some View {
    VStack(spacing: 3) {
      Image(randomImage)
        .resizable()
        .scaledToFit()
        .layoutPriority(1)
      
      HeaderView(title: "Credits")
      
      Text("Arthur Neves")
        .foregroundColor(.primary)
        .fontWeight(.bold)
      
      Text("Developer")
        .font(.footnote)
        .foregroundColor(.secondary)
        .fontWeight(.light)
    } //: VStack
  }
}

struct CreditsView_Previews: PreviewProvider {
  static var previews: some View {
    CreditsView()
  }
}
