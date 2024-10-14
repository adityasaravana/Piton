//
//  RandomTextLockView.swift
//  Piton
//
//  Created by Aditya Saravana on 10/10/24.
//

import SwiftUI

struct RandomTextLockView: View {
    @State private var randomWords: [String] = []
    @State private var userInput: String = ""
    
    var wordCount: Int
    
    var body: some View {
        VStack {
            Text("Type in the following words to unlock:")
                .font(.headline)
                .padding(.bottom, 10)
            
            // Display the random words that the user needs to type
            ScrollView {
                Text(randomWords.joined(separator: " "))
                    .font(.body)
                    .padding()
            }
            .frame(height: 200) // Adjust height as needed
            
            // Input field for the user, allowing multi-line text input
            TextEditor(text: $userInput)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(.primary, lineWidth: 2))
                .frame(height: 200) // Expanding text field
                .padding()
            
            // Unlock button to check user input
            Button("Check Input") {
                checkInput()
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
            .padding()
        }
        .padding()
        .onAppear {
            randomWords = generateRandomWords(amount: wordCount)
        }
    }
    
    func checkInput() {
        let targetString = randomWords.joined(separator: "").trimmingCharacters(in: .whitespacesAndNewlines)
        if userInput.trimmingCharacters(in: .whitespacesAndNewlines) == targetString {
            print("unlocked")
        }
    }
}

#Preview {
    RandomTextLockView(wordCount: 100)
}
