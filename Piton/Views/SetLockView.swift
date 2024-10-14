//
//  SetLockView.swift
//  Piton
//
//  Created by Aditya Saravana on 10/8/24.
//

import SwiftUI

struct SetLockView: View {
    @EnvironmentObject var vault: Vault
    
    @State var showSetRandomTextLockView = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 40) {
//                Button("None") {
//                    vault.lockType = .none
//                }
                Text("Set a lock")
                
                Button("Random Text") {
                    showSetRandomTextLockView = true
                }
            }
            .sheet(isPresented: $showSetRandomTextLockView) {
                SetRandomTextLockView(isPresented: $showSetRandomTextLockView, lockType: $vault.lockType)
            }
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button("Cancel") {
//                        isPresented = false
//                    }
//                }
//            }
        }
    }
}

struct SetRandomTextLockView: View {
    @Binding var isPresented: Bool
    @Binding var lockType: LockType
    @State var randomTextAmount = 0
    
    var body: some View {
        NavigationStack {
            Form {
                Section(content: {
                    Stepper("\(randomTextAmount) random words", value: $randomTextAmount, step: 100)
                    
                    
                    Button("Done") {
                        lockType = .randomText(words: randomTextAmount)
                        isPresented = false
                    }
                    .disabled(randomTextAmount == 0)
                   
                }, footer: {
                    Text("The random text'll take \(randomTextAmount / 36) minutes to type and look like this:")
                    Text(generateRandomWords(amount: randomTextAmount).joined(separator: " "))
                })
//                .buttonStyle(.borderedProminent)
//                .buttonBorderShape(.capsule)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

#Preview {
    SetLockView().environmentObject(Vault())
}
