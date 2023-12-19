//
//  ContentView.swift
//  AppleLoginPractice
//
//  Created by Nick on 2023/12/19.
//

import SwiftUI
import AuthenticationServices

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            SignInWithAppleView()
        }
        .padding()
    }
    
    private func showAppleLogin() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
    }
    
}

#Preview {
    ContentView()
}
