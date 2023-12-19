//
//  SignInWithAppleView.swift
//  AppleLoginPractice
//
//  Created by Nick on 2023/12/19.
//

import SwiftUI
import AuthenticationServices

final class SignInWithAppleView: UIViewRepresentable {
    
    func makeUIView(context: Context) -> some UIView {
        return ASAuthorizationAppleIDButton()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
    
}
