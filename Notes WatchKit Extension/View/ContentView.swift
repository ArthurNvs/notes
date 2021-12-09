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
  
  func load() {
    DispatchQueue.main.async {
      do {
        // 1. Get the notes URL path
        let url = getDocumentDirectory().appendingPathComponent("notes")
        // 2. Create new property for data
        let data = try Data(contentsOf: url)
        // 3. Decode data
        notes = try JSONDecoder().decode([Note].self, from: data)
      } catch {
        // Do nothing
      }
    }
  }
  
  func delete(offsets: IndexSet) {
    withAnimation {
      notes.remove(atOffsets: offsets)
      save()
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
      
      if notes.count >= 1 {
        List {
          ForEach(0..<notes.count, id: \.self) { i in
            NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
              HStack {
                Capsule()
                  .frame(width: 4)
                  .foregroundColor(.accentColor)
                Text(notes[i].text)
                  .lineLimit(1)
                  .padding(.leading, 5)
              }
            } //: HStack
          } //: ForEach
          .onDelete(perform: delete)
        }
      } else {
        Spacer()
        Image(systemName: "note.text")
          .resizable()
          .scaledToFit()
          .foregroundColor(.gray)
          .opacity(0.25)
          .padding(25)
        Spacer()
      } //: List
    } //: VStack
    .navigationTitle("Notes")
    .onAppear(perform: {
      load()
    })
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
