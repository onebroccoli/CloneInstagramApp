//
//  SignInWithGoogle.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/23/21.
//

import Foundation
import SwiftUI
import GoogleSignIn
import Firebase

class SignInWithGoogle: NSObject {
    
    static let instance = SignInWithGoogle()
    var onboardingView: OnboardingView!
    
    func startSignInWithGoogleFlow(view: OnboardingView) {
        self.onboardingView = view
        //        GIDSignIn.sharedInstance().delegate = self
        //        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.first?.rootViewController
        //        GIDSignIn.sharedInstance()?.presentingViewController.modalPresentationStyle = .fullScreen
        //        GIDSignIn.sharedInstance().signIn()
        
        
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: (UIApplication.shared.windows.first?.rootViewController)!) {
            [unowned self] user, error in
            
            
            
                if let error = error {
                    print ("ERROR SIGNING INTO GOOGLE")
                    self.onboardingView.showError.toggle()
                    return
                }
                
                guard let profile = user?.profile else {return}
                let fullName: String = profile.name
                let email: String = profile.email
                
                guard let authentication = user?.authentication else {
                    return
                    
                }
                guard let idToken = authentication.idToken else {
                    return
                    
                }
                let accessToken = authentication.accessToken
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
                
                print ("SIGN INTO FIREBASE NOW. WITH NAME: \(fullName) and EMAIL: \(email)")

                
                //for apple need to do the same if has sign in with apple
                self.onboardingView.connectToFirebase(name: fullName, email: email, provider: "google", credential: credential)
                
                // ...
        }
    }
}
