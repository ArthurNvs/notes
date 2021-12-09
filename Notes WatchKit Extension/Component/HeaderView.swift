//
//  HeaderView.swift
//  Notes WatchKit Extension
//
//  Created by Arthur Neves on 09/12/21.
//

import SwiftUI

struct HeaderView: View {
  var title: String = ""
  
  var body: some View {
    VStack {
      // TITLE
      if title != "" {
        Text(title.uppercased())
          .font(.title3)
          .fontWeight(.bold)
          .foregroundColor(.accentColor)
      }
      // SEPARATOR
      
      HStack {
        Capsule()
          .frame(height: 1)
        
        Image(systemName: "note.text")
        
        Capsule()
          .frame(height: 1)
      } //: HStack
      .foregroundColor(.accentColor)
    } //: VStack
  }
}

struct HeaderView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      HeaderView(title: "Credits")
      
      HeaderView()
    }
  }
}
