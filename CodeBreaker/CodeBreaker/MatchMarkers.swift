//
//  MatchMarkers.swift
//  CodeBreaker
//
//  Created by Su Sundee on 31/12/25.
//
import SwiftUI

enum Match {
  case nomatch
  case exact
  case inexact
}

struct MatchMarkers: View {
  
  var matches: [Match]
  
  var body: some View {
    HStack {
      // Compute counts once for performance and correctness
      let exactCount = matches.filter { $0 == .exact }.count
      let foundCount = matches.filter { $0 != .nomatch }.count
      
      let total = matches.count
      let columns = 2
      let rows = (total + columns - 1) / columns
      
      VStack(alignment: .center, spacing: 4) {
        ForEach(0..<rows, id: \.self) { row in
          HStack(spacing: 4) {
            ForEach(0..<columns, id: \.self) { col in
              let peg = row * columns + col
              if peg < total {
                matchMarker(peg: peg,
                            exactCount: exactCount,
                            foundCount: foundCount)
                .frame(width: 10, height: 10)
              }
            }
          }
        }
      }
    }
  }
  
  // black peg -> correct color and the correct position
  // white peg -> correct colr but in wrong position
  // no peg -> incorrect color
  // showing black, white, or no peg doesn't matter.
  func matchMarker(peg: Int, exactCount: Int, foundCount: Int) -> some View {
    Circle()
      .fill(exactCount > peg ? Color.primary : Color.clear)
      .stroke(foundCount > peg ? Color.primary : Color.clear, lineWidth: 2)
      .aspectRatio(1, contentMode: .fit)
  }
}

struct MatchMarkersPreview: View {
  
  var matches: [Match]
  
  var body: some View {
    HStack {
      ForEach(matches.enumerated(), id: \.offset) { _ in
        Circle()
          .foregroundStyle(codeColors.randomElement() ?? .teal)
      }
      MatchMarkers(matches: matches)
    }
    .padding(2)
  }
}

let codeColors: [Color] = [.blue, .red, .purple, .green, .orange, .brown, .yellow, .gray]

#Preview {
  MatchMarkersPreview(matches: [.exact, .inexact, .nomatch])
  MatchMarkersPreview(matches: [.exact, .inexact, .nomatch, .inexact])
  MatchMarkersPreview(matches: [.exact, .inexact, .nomatch, .inexact, .exact, .exact])
  MatchMarkersPreview(matches: [.exact, .inexact, .nomatch, .inexact, .exact, .exact])
  MatchMarkersPreview(matches: [.exact, .inexact, .nomatch, .inexact, .exact, .exact])
}

