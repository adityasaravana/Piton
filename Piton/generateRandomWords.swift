//
//  generateRandomWords.swift
//  Piton
//
//  Created by Aditya Saravana on 10/14/24.
//

import Foundation

func generateRandomWords(amount: Int) -> [String] {
    let vocabulary = ["apple", "banana", "orange", "grape", "watermelon", "pineapple", "strawberry", "blueberry", "cherry", "mango"]
    
    // Use map to generate 'amount' random words
    let randomWords = (0..<amount).map { _ in vocabulary.randomElement()! }
    
    return randomWords
}
