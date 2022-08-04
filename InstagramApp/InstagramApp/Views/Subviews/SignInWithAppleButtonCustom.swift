//
//  SignInWithAppleButtonCustom.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/22/21.
//

import Foundation
import SwiftUI
import AuthenticationServices
struct SignInWithAppleButtonCustom: UIViewRepresentable {
    
    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {
        return ASAuthorizationAppleIDButton(authorizationButtonType: .default, authorizationButtonStyle: .black)
    }
    
    
    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) {
    }
}
