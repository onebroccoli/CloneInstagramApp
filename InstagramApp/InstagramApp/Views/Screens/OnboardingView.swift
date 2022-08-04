//
//  OnboardingView.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/22/21.
//

import SwiftUI
import Firebase

struct OnboardingView: View {
    @Environment(\.presentationMode) var presentationMode
    @State var showOnboardingPart2: Bool = false
    @State var showError: Bool = false
    
    @State var displayName: String = ""
    @State var email: String = ""
    @State var providerID: String = ""
    @State var provider: String = ""
    
    var body: some View {
        VStack(spacing: 10) {
            Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .shadow(radius: 12)
            
            Text("Welcome to InstaDog!")
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(Color.MyTheme.purpleColor)
            
            Text("InstaDog is the #1 app for posting pictures of your dog. We are happy to have you!")
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.MyTheme.purpleColor)
                .padding()
            
            // MARK: Apple Button
            Button(action: {
//                showOnboardingPart2.toggle()
                SignInWithGoogle.instance.startSignInWithGoogleFlow(view: self)
                
            }, label: {
                    SignInWithAppleButtonCustom()
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
            })
            
            // MARK: Google Button

            Button(action: {
                SignInWithGoogle.instance.startSignInWithGoogleFlow(view: self)
            }, label: {
                HStack {
                    Image(systemName: "globe")
                    Text("Sign in with Google")
                }
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(Color(.sRGB, red: 222/255, green: 82/255, blue: 70/255, opacity: 1.0))
                .cornerRadius(6)
                .font(.system(size: 23, weight: .medium, design: .default))

            })
            .accentColor(Color.white)
            
            // MARK: Guest Button

            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Continue as guest".uppercased())
                    .font(.headline)
                    .fontWeight(.medium)
                    .padding()
                
            })
            .accentColor(.black)
            
        }
        .padding(.all, 20)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .frame( maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(Color.MyTheme.beigeColor)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .fullScreenCover(isPresented: $showOnboardingPart2, onDismiss: {
            self.presentationMode.wrappedValue.dismiss()
        }, content: {
            OnboardignViewPart2(displayName: $displayName, email: $email, providerID: $providerID, provider: $provider)
        })
        .alert(isPresented: $showError, content: {
            return Alert(title: Text("Error signing in 😭"))
        })
        
    }
    
    // MARK: FUNCTIONS
    
    func connectToFirebase(name: String, email: String, provider: String, credential: AuthCredential){
        AuthService.instance.logInUserToFirebase(credential: credential) { (returnedProviderID, isError, isNewUser, returnedUserID) in
            if let newUser = isNewUser {
                if newUser {
                    // NEW USER
                    if let providerID = returnedProviderID, !isError {
                        //SUCCESS, new user, continue to onboarding part2
                        self.displayName = name
                        self.email = email
                        self.providerID = providerID
                        self.provider = provider
                        self.showOnboardingPart2.toggle()
                } else {
                    //ERROR
                    print("Error getting provider ID from log in user to Firebase")
                    self.showError.toggle()
                }
            } else {
                //EXISTING USER
                if let userID = returnedUserID {
                    // SUCCESS, LOG INTO APP
                    AuthService.instance.logInUserToApp(userID: userID) { (success) in
                        if success {
                            print ("Succssful log into existing user")
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            print ("Error logging existing user into our app")
                            self.showError.toggle()
                        }
                    }
                } else {
                    // ERROR
                    print("Error getting user ID from log-in user to Firebase")
                    self.showError.toggle()
                }
            }
        } else {
            // ERROR
            print("Error getting into from log-in user to Firebase")
            self.showError.toggle()
                
            }
            
        }
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
