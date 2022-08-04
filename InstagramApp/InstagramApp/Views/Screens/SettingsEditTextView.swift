//
//  SettingsEditTextView.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/22/21.
//

import SwiftUI



struct SettingsEditTextView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme

    @State var submissionText: String = ""
    @State var title: String
    @State var description: String
    @State var placeholder: String
    @State var settingsEditTextOption: SettingsEditTextOption
    @Binding var profileText: String
    
    
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @State var showSuccessAlert: Bool = false
    
    let haptics = UINotificationFeedbackGenerator() //vibrator feature when notification shows up
    
    
    var body: some View {
        VStack {
            HStack {
                Text(description)
                Spacer(minLength: 0)

            }
            
            TextField(placeholder, text: $submissionText)
                .padding()
                .frame(height: 60)
                .frame(maxWidth: .infinity)
                .background(colorScheme == .light ? Color.MyTheme.beigeColor : Color.MyTheme.purpleColor)
                .cornerRadius(12)
                .font(.headline)
                .autocapitalization(.sentences)
            
            Button(action: {
                if textIsAppropriate() {
                    saveText()
                }
            }, label: {
                Text("Save".uppercased())
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
                    .cornerRadius(12)
                
            })
            .accentColor(colorScheme == .light ? Color.MyTheme.yellowColor : Color.MyTheme.purpleColor)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationBarTitle(title)
        .alert(isPresented: $showSuccessAlert) { () -> Alert in
            return Alert(title: Text("Saved! 😋"), message: nil, dismissButton: .default(Text("OK"), action:{
               dismissView()
                
            }))
        }
    
    }
    
    // MARK: FUNCTIONS
    func dismissView() {
        self.haptics.notificationOccurred(.success)
        self.presentationMode.wrappedValue.dismiss() //after save, the screen disappear and go back to setting page
    }
    
    func textIsAppropriate() -> Bool {
        //Check if the text has curses
        //Check if the text is long enough
        //Check if the text is blank
        //Check for innapropriate things
        
        //check for bad words
        let badWordArray: [String] = ["shit", "ass"]
        let words = submissionText.components(separatedBy: " ")
        for word in words {
            if badWordArray.contains(word) {
                return false
            }
        }
        //check for minmum count
        if submissionText.count < 3 {
            return false
        }
        return true
    }
    
    func saveText() {
        
        guard let userID = currentUserID else { return }
        
        switch settingsEditTextOption {
        case .displayName:
            // update the UI on the profile
            self.profileText = submissionText
            //update the userdefault
            UserDefaults.standard.set(submissionText, forKey: CurrentUserDefaults.displayName)
            // updte on all of the user's posts
            DataService.instance.updateDiplayNameOnPosts(userID: userID, displayName: submissionText)
            // update on the user's profile in DB
            AuthService.instance.updateUserDisplayName(userID: userID, displayName: submissionText) { (success) in
                if success {
                    self.showSuccessAlert.toggle()
                }
            }
        case .bio:
            // update the UI on the profile
            self.profileText = submissionText
            //update the userdefault
            UserDefaults.standard.set(submissionText, forKey: CurrentUserDefaults.bio)
        // update on the user's profile in DB
            AuthService.instance.updateUserbio(userID: userID, bio: submissionText) { (success) in
                if success {
                    self.showSuccessAlert.toggle()
                }
            }
        }
    }

    
}

struct SettingsEditTextView_Previews: PreviewProvider {
    @State static var text: String = ""
    static var previews: some View {
        NavigationView {
            SettingsEditTextView(title: "Test Title", description: "This is a description", placeholder: "Test placeholder", settingsEditTextOption: .displayName, profileText: $text)
                .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        }
    }
}
