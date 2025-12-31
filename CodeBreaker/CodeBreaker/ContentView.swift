//
//  ContentView.swift
//  CodeBreaker
//
//  Created by Su Sundee on 27/12/25.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    VStack {
      pegs(colors: [.blue, .red, .green, .blue])
      pegs(colors: [.red, .red, .green, .blue])
      pegs(colors: [.green, .red, .green, .blue])
    }
    .padding()
  }
  
  
  func pegs(colors: Array<Color>) -> some View {
    HStack {
      ForEach(Array(colors.enumerated()), id: \.offset) { index, color in
        RoundedRectangle(cornerRadius: 10)
          .aspectRatio(1, contentMode: .fit)
          .foregroundStyle(color)
      }
      MatchMarkers(matches: [.exact, .inexact, .nomatch, .inexact])
    }
  }
}

#Preview {
  ContentView()
}
