//
//  ContentView.swift
//  Dion
//
//  Created by Aditya Saravana on 10/7/24.
//

import SwiftUI
import MIPinCodeView

private enum SetPasswordViewStage {
    case set
    case confirm
}

struct SetPasswordView: View {
    @Binding var password: String
    @Binding var isPresented: Bool
    
    @State private var setPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var stage: SetPasswordViewStage = .set
    @State private var showPasswordsNotMatchingAlert = false
    
    var titleText: String {
        switch stage {
        case .set:
            return "Enter Screen Time password"
        case .confirm:
            return "Confirm password"
        }
    }
    
    var buttonText: String {
        switch stage {
        case .set:
            return "Next"
        case .confirm:
            return "Done"
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Text(titleText).font(.headline)
                
                switch stage {
                case .set:
                    MIPinCodeView(
                        pin: $setPassword,
                        length: 4,
                        isSecure: false,
                        style: .boxed,
                        backgroundColor: .gray,
                        textColor: .white,
                        cornerRadius: 8,
                        width: 40,
                        height: 40,
                        keyboardType: .numberPad
                    )
                case .confirm:
                    MIPinCodeView(
                        pin: $confirmPassword,
                        length: 4,
                        isSecure: false,
                        style: .boxed,
                        backgroundColor: .gray,
                        textColor: .white,
                        cornerRadius: 8,
                        width: 40,
                        height: 40,
                        keyboardType: .numberPad
                    )
                }
                
                Spacer()
                
                Button(buttonText) {
                    withAnimation {
                        switch stage {
                        case .set:
                            stage = .confirm
                        case .confirm:
                            if setPassword != confirmPassword {
                                showPasswordsNotMatchingAlert = true
                            } else {
                                password = setPassword
                                isPresented = false
                            }
                        }
                    }
                }
                .disabled(setPassword.count != 4)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .keyboardShortcut(.defaultAction)
            }
            .alert("Your passwords don't match.", isPresented: $showPasswordsNotMatchingAlert) {
                Button("OK", role: .cancel) { }
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
    SetPasswordView(password: .constant(""), isPresented: .constant(true))
}
