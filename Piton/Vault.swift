//
//  Vault.swift
//  Piton
//
//  Created by Aditya Saravana on 10/7/24.
//

import Foundation
import Valet

class Vault: ObservableObject {
    static let shared = Vault()
    
    let valet = SinglePromptSecureEnclaveValet.valet(with: Identifier(nonEmpty: "com.adityasaravana.Piton")!, accessControl: .userPresence)
    
    @Published var screenTimePassword: String = "" {
        didSet {
            print("screenTimePassword changed")
            do {
                try valet.setString(screenTimePassword, forKey: SecureEnclaveKeys.screenTimePasswordSecureEnclaveKey)
                print("wrote password to Secure Enclave")
            } catch {
//                fatalError("Could not write Screen Time Password to Secure Enclave. Email aditya.saravana@icloud.com for help.")
                print(error.localizedDescription)
            }
        }
    }
    
    var screenTimePasswordIsValid: Bool {
        return screenTimePassword.count == 4 && screenTimePassword.allSatisfy { $0.isNumber }
    }
    
    @Published var lockType: LockType = .none {
        didSet {
            print("screenTimePassword changed")
            do {
                try valet.setString(LockType.encode(lockType), forKey: SecureEnclaveKeys.lockType)
                print("wrote password to Secure Enclave")
            } catch {
//                fatalError("Could not write Screen Time Password to Secure Enclave. Email aditya.saravana@icloud.com for help.")
                print(error.localizedDescription)
            }
        }
    }
    
    func readFromSecureEnclave(_ key: String) -> String {
        do {
            let password = try valet.string(forKey: SecureEnclaveKeys.screenTimePasswordSecureEnclaveKey, withPrompt: "")
            return password
        } catch {
            return ""
        }
    }
    
    init() {
        self.screenTimePassword = readFromSecureEnclave(SecureEnclaveKeys.screenTimePasswordSecureEnclaveKey)
        self.lockType = LockType.decode(readFromSecureEnclave(SecureEnclaveKeys.lockType))
    }
}
