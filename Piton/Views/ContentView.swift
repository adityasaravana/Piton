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
    var body: some View {
        VStack {
            Text(vault.screenTimePassword)
            Button("Set Password") {
                showSetPasswordSheet = true
            }
        }
        .padding()
        .sheet(isPresented: $showSetPasswordSheet) {
            SetPasswordView(password: $vault.screenTimePassword, isPresented: $showSetPasswordSheet)
        }
    }
}

#Preview {
    ContentView()
}
