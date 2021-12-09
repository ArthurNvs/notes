//
//  ContentView.swift
//  Notes WatchKit Extension
//
//  Created by Arthur Neves on 09/12/21.
//

import SwiftUI

struct ContentView: View {
  
  @State private var notes: [Note] = [Note]()
  @State private var text: String = ""
  
  func save() {
    dump(notes)
  }
  
  var body: some View {
    VStack {
      HStack (alignment: .center, spacing: 6) {
        TextField("Add New Note", text: $text)
        
        Button(action: {
          guard !text.isEmpty else { return }
          
          let note = Note(id: UUID(), text: text)
          notes.append(note)
          
          text = ""
          
          save()
        }) {
          Image(systemName: "plus.circle")
            .font(.system(size: 42, weight: .semibold))
        }
        .fixedSize()
        .buttonStyle(PlainButtonStyle())
        .foregroundColor(.accentColor)
        //.buttonStyle(BorderedButtonStyle(tint: .accentColor))
      } //: HStack
      
      Spacer()
      
      Text("\(notes.count)")
    } //: VStack
    .navigationTitle("Notes")
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
