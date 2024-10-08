//
//  Vault.swift
//  Piton
//
//  Created by Aditya Saravana on 10/7/24.
//

import Foundation
import Valet

class Vault: ObservableObject {
    let valet = SinglePromptSecureEnclaveValet.valet(with: Identifier(nonEmpty: "com.adityasaravana.Piton")!, accessControl: .userPresence)
    
    @Published var screenTimePassword: String = "" {
        didSet {
            print("screenTimePassword changed")
            do {
                try valet.setString(screenTimePassword, forKey: Constants.screenTimePasswordSecureEnclaveKey)
            } catch {
                fatalError("Could not write Screen Time Password to Secure Enclave. Email aditya.saravana@icloud.com for help.")
            }
        }
    }
    
    func readScreenTimePassword() -> String {
        do {
            let password = try valet.string(forKey: Constants.screenTimePasswordSecureEnclaveKey, withPrompt: "")
            return password
        } catch {
            return ""
        }
    }
    
    init() {
        self.screenTimePassword = readScreenTimePassword()
    }
}
