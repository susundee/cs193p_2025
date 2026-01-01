//
//  ContentView.swift
//  CodeBreaker
//
//  Created by Su Sundee on 27/12/25.
//

import SwiftUI

struct CodeBreakerView: View {
  
  @State var game = CodeBreaker()
  
  var body: some View {
    VStack {
      view(for: game.masterCode)
      ScrollView {
        view(for: game.guess)
        ForEach(game.attempts.enumerated().reversed(), id: \.offset) { idx, _ in
          view(for: game.attempts[idx])
        }
      }
    }
    .padding()
  }
  
  var guessButton: some View {
    Button("Guess") {
      withAnimation {
        game.attemptGuess()
      }
    }
    .font(.system(size: 80))
    .minimumScaleFactor(0.1)
  }
  
  func view(for code: Code) -> some View {
    HStack {
      ForEach(Array(code.pegs.enumerated()), id: \.offset) { index, color in
        RoundedRectangle(cornerRadius: 10)
          .contentShape(Rectangle())
          .aspectRatio(1, contentMode: .fit)
          .foregroundStyle(color)
          .onTapGesture {
            if code.kind == .guess {
              game.changeGuessPeg(at: index)
            }
          }
      }
      MatchMarkers(matches: code.matches)
        .overlay {
          if code.kind == .guess {
            guessButton
          }
        }
    }
  }
  
}

#Preview {
  CodeBreakerView()
}
