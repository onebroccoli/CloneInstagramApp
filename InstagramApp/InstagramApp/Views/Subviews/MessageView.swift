//
//  MessageView.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/18/21.
//

import SwiftUI

struct MessageView: View {
    @State var comment: CommentModel
    @State var profilePicture: UIImage = UIImage(named: "logo.loading")!
    
    var body: some View {
        HStack {
            
            // MARK: PROFILE IMAGE
//            Image("dog1")
            //click comment profile will go to user profile, use lazyview to only create link when clicking
            NavigationLink(
                destination: LazyView(content: {
                    profileView(isMyProfile: false, profileDisplayName: comment.username, profileUserID: comment.userID, posts: PostArrayObject(userID: comment.userID))
                })) {
                Image(uiImage: profilePicture)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 40, alignment: .center)
                    .cornerRadius(20)
            }
            
            
            VStack(alignment: .leading, spacing: 4, content: {
//                Text("USERNAME")
             // MARK USERNAME
                Text(comment.username)
                    .font(.caption)
                    .foregroundColor(.gray)
                
//                Text("This is a new comment here")
             // MARK CONTENT
                Text(comment.content)
                    .padding(.all, 10)
                    .foregroundColor(.primary)
                    .background(Color.gray)
                    .cornerRadius(10)
            })
            
            Spacer()
        }
        .onAppear {
            getProfileImage()
        }
    }
    
    // MARK: FUNCTIONS
    func getProfileImage() {
        ImageManager.instance.downloadProfileImage(userID: comment.userID) { (returnedImage) in
            if let image = returnedImage {
                self.profilePicture = image
            }
        }
    }
}



struct MessageView_Previews: PreviewProvider {
    
    static var comment: CommentModel = CommentModel(commentID: "", userID: "", username: "Joe Green", content: "this photo is really cool, haha", dateCreated: Date())
    static var previews: some View {
        MessageView(comment: comment)            .previewLayout(.sizeThatFits)
    }
}

