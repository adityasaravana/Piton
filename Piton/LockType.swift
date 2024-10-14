//
//  LockType.swift
//  Piton
//
//  Created by Aditya Saravana on 10/8/24.
//

import Foundation

enum LockType: Equatable {
    case error(string: String)
    case none
    case randomText(words: Int)
    
    static func encode(_ lockType: LockType) -> String {
        switch lockType {
        case .none:
            return "none"
        case .randomText(let words):
            return "randomText(\(words))"
        case .error:
            return ""
        }
    }
    
    static func decode(_ lockTypeString: String) -> LockType {
        if lockTypeString == "none" {
            return LockType.none
        } else if lockTypeString.hasPrefix("randomText") {
            let startIndex = lockTypeString.index(lockTypeString.firstIndex(of: "(")!, offsetBy: 1)
            let endIndex = lockTypeString.index(lockTypeString.firstIndex(of: ")")!, offsetBy: -1)
            let wordsString = lockTypeString[startIndex...endIndex]
            
            if let words = Int(wordsString) {
                return .randomText(words: words)
            }
        }
        
        return .error(string: "LockType.decode returned .error")
    }
}
