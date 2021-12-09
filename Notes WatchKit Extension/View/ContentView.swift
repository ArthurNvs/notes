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
  
  func getDocumentDirectory() -> URL {
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return path[0]
  }
  
  func save() {
    do {
      // 1. Convert notes array to data using JSONEncoder
      let data = try JSONEncoder().encode(notes)
      // 2. Create new URL to save file using getDocumentDirectory
      let url = getDocumentDirectory().appendingPathComponent("notes")
      // 3. Write data to the given URL
      try data.write(to: url)
    } catch {
      print("saving data failed!")
    }
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
