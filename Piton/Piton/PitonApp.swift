//
//  PitonApp.swift
//  Piton
//
//  Created by Aditya Saravana on 10/7/24.
//

import SwiftUI

@main
struct PitonApp: App {
    let vault = Vault.shared
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(vault)
        }
    }
}
