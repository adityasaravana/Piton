//
//  ContentView.swift
//  Piton
//
//  Created by Aditya Saravana on 10/7/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var vault: Vault
    @State var showSetPasswordSheet = false
    @State var showRandomTextLockView = false
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            if !vault.screenTimePasswordIsValid {
                Text("Welcome to Piton")
                
                Text("Explanation, information, prompt here")
                
                Button("Set Password") {
                    showSetPasswordSheet = true
                }
                .onAppear {
                    vault.screenTimePassword.removeAll()
                }
            } else if vault.screenTimePasswordIsValid && (vault.lockType == LockType.none || {
                if case .error = vault.lockType {
                    return true
                } else {
                    return false
                }
            }()) {
                SetLockView()
            } else {
                Text("Setup complete, this is the home screen now")
                
                Text("DEBUG:")
                Text(LockType.encode(vault.lockType))
                Text(vault.screenTimePassword)
                
                Button("Show Random Text Lock View") {
                    showRandomTextLockView = true
                }
            }
            
            Spacer()
            
            Button("DEBUG: Reset") {
                vault.screenTimePassword.removeAll()
                vault.lockType = .none
            }
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.capsule)
        }
        .padding()
        .onAppear {
            print(vault.screenTimePasswordIsValid)
            print(vault.lockType)
        }
        .sheet(isPresented: $showSetPasswordSheet) {
            SetPasswordView(password: $vault.screenTimePassword, isPresented: $showSetPasswordSheet)
        }
        .sheet(isPresented: $showRandomTextLockView) {
            RandomTextLockView(wordCount: 3)
        }
    }
}

#Preview {
    ContentView().environmentObject(Vault.shared)
}
