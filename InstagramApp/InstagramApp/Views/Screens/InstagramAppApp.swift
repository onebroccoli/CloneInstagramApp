//
//  InstagramAppApp.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/18/21.
//

import SwiftUI
import FirebaseCore
import FirebaseAnalytics
import GoogleSignIn
@main
struct InstagramAppApp: App {
    init(){
        FirebaseApp.configure()
        Analytics.setAnalyticsCollectionEnabled(true)
        
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onOpenURL(perform: { url in
                    GIDSignIn.sharedInstance.handle(url) //for google sign in
                })
        }
    }
}
