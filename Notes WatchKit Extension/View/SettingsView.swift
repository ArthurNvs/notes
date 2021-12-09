//
//  SettingsView.swift
//  Notes WatchKit Extension
//
//  Created by Arthur Neves on 09/12/21.
//

import SwiftUI

struct SettingsView: View {
  @AppStorage("lineCount") var lineCount = 1
  @State private var value: Float = 1.0
  
  func update() {
    lineCount = Int(value)
  }
  
  var body: some View {
    VStack(spacing: 8) {
      // HEADER
      HeaderView(title: "Settings")
      
      // LINE COUNT
      Text("Lines: \(lineCount)".uppercased())
        .fontWeight(.bold)
      
      // SLIDER
      Slider(value: Binding(get: {
        self.value
      }, set: {(newValue) in
        self.value = newValue
        self.update()
      }), in: 1...4, step: 1)
        .accentColor(.accentColor)
    } //: VStack
  }
}

struct SettingsView_Previews: PreviewProvider {
  static var previews: some View {
    SettingsView()
  }
}
