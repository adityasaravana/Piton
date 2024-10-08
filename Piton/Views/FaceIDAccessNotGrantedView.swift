//
//  FaceIDAccessNotGrantedView.swift
//  Piton
//
//  Created by Aditya Saravana on 10/7/24.
//

import SwiftUI

struct FaceIDAccessNotGrantedView: View {
    var body: some View {
        ZStack {
            Color(UIColor.systemGroupedBackground).ignoresSafeArea(.all)
            
            VStack(alignment: .center, spacing: 23) {
                Spacer()
                
                Image(systemName: "faceid")
                    .resizable()
                    .frame(width: 75, height: 75)
                    .foregroundStyle(Color.accentColor)
                
                Text("Piton needs access to biometrics")
                    .bold()
                    .font(.title)
                
                Text("Piton stores data in the Secure Enclave, the most secure place to store anything on your phone, and needs access to biometrics to confirm it's you when reading information from it.")
                    .padding(.bottom, 90)

                Spacer()
                
                Button("Open Settings") {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }
                .keyboardShortcut(.defaultAction)
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                .padding()
            }
            .padding()
            .multilineTextAlignment(.center)
            .ignoresSafeArea()
        }
    }
}
#Preview {
    FaceIDAccessNotGrantedView()
}
