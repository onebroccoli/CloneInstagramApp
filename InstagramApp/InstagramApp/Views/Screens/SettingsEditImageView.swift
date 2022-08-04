//
//  SettingsEditImageView.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/22/21.
//

import SwiftUI

struct SettingsEditImageView: View {
    @State var title: String
    @State var description: String
    @State var selectedImage: UIImage //image shown on this screen
    @Binding var profileImage: UIImage // image shown on the profile
    @State var sourceType: UIImagePickerController.SourceType = UIImagePickerController.SourceType.photoLibrary
    
    @State var showImagePicker: Bool = false
    @AppStorage(CurrentUserDefaults.userID) var cuurentUserID: String?
    @State var showSuccessAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text(description)
                Spacer(minLength: 0)
                
            }
            
            Image(uiImage: selectedImage)
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .clipped() //crop to square
                .cornerRadius(12)
            
            Button(action: {
                showImagePicker.toggle()
            }, label: {
                Text("Import".uppercased())
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.yellowColor)
                    .cornerRadius(12)
                
            })
            .accentColor(Color.MyTheme.purpleColor)
            .sheet(isPresented: $showImagePicker, content: {
                ImagePicker(imageSelected: $selectedImage, sourceType: $sourceType)
            })
            
            
            
            Button(action: {
                saveImage()
            }, label: {
                Text("Save".uppercased())
                    .font(.title3)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding()
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(Color.MyTheme.purpleColor)
                    .cornerRadius(12)
                
            })
            .accentColor(Color.MyTheme.yellowColor)
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .navigationBarTitle(title)
        .alert(isPresented: $showSuccessAlert) { () -> Alert in
            return Alert(title: Text("Success! 🥰"), message: nil, dismissButton: .default(Text("OK"), action: {
                self.presentationMode.wrappedValue.dismiss()
            }))
        }
        
    }
    
    // MARK: FUNCTIONS
    func saveImage() {
        guard let userID = cuurentUserID else {return}
        // update UI of the profile
        self.profileImage = selectedImage
        
        // update profile image in database
        ImageManager.instance.uploadProfileImage(userID: userID, image: selectedImage)
        self.showSuccessAlert.toggle()
    }
    
}

struct SettingsEditImageView_Previews: PreviewProvider {
    @State static var image: UIImage = UIImage(named: "dog1")!
    static var previews: some View {
        NavigationView {
            SettingsEditImageView(title: "Title", description: "Description", selectedImage: UIImage(named: "dog1")!, profileImage: $image)
        }
        
    }
}
