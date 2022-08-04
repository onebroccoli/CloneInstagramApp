//
//  CommentsView.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/18/21.
//

import SwiftUI

struct CommentsView: View {
    @Environment(\.colorScheme) var colorScheme
    @State var submissionText: String = ""
    @State var commentArray = [CommentModel]()
    
    var post: PostModel
    
    @State var profilePicture: UIImage = UIImage(named: "logo.loading")!
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
    @AppStorage(CurrentUserDefaults.displayName) var currentUserDisplayName: String?

    var body: some View {
        VStack {
            
            // Message scrollview
            ScrollView {
                LazyVStack {
                    ForEach(commentArray, id: \.self){ comment in
                        MessageView(comment: comment)
                    }
                }
            }
            
            
            // bottom Hstack
            HStack {
//                    Image("dog1")
                    Image(uiImage: profilePicture)
                      .resizable()
                      .scaledToFill()
                      .frame(width: 40, height: 40, alignment: .center)
                      .cornerRadius(20)
                
                TextField("Add a comment here....", text: $submissionText ) //Let's call it at state var submission, text of type string and let's set it equal to a blank string.So submission text type string equals blank string. And we're going to bind this variable to this text by simply writing the money sign and then calling submission text.
                
                Button(action: {
                    if textIsAppropriate(){
                        addComment()
                    }
                }, label: {
                    Image(systemName: "paperplane.fill")
                        .font(.title2)
                })
                .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
            }
            .padding(.all, 6)
            
          }
          .padding(.horizontal)
          .navigationTitle("Comments")
          .navigationBarTitleDisplayMode(.inline)
          .onAppear(perform: {
            getComments()
            getProfilePicture()
          })
    }
    
    
    
    // MARK: FUNCTIONS
    func getProfilePicture() {
        
        guard let userID = currentUserID else {return}
        ImageManager.instance.downloadProfileImage(userID: userID) { (returnedImage) in
            if let image = returnedImage {
                self.profilePicture = image
            }
        }
    }
    
//    func getComments() {
//        print ("get comments from database")
//        let comment1 = CommentModel(commentID: "", userID: "", username: "Green", content: "first one", dateCreated: Date())
//        let comment2 = CommentModel(commentID: "", userID: "", username: "Yello", content: "second one", dateCreated: Date())
//        let comment3 = CommentModel(commentID: "", userID: "", username: "Red", content: "Third one", dateCreated: Date())
//        let comment4 = CommentModel(commentID: "", userID: "", username: "Blue", content: "fourth one", dateCreated: Date())
//
//        self.commentArray.append(comment1)
//        self.commentArray.append(comment2)
//        self.commentArray.append(comment3)
//        self.commentArray.append(comment4)
//    }
    
    func getComments() {
        
        // make sure comments is empty before we load
        guard self.commentArray.isEmpty else {return}
        print ("get comments from database")

        if let caption = post.caption, caption.count > 1 {
            let captionComment = CommentModel(commentID: "", userID: post.userID, username: post.username, content: caption, dateCreated: post.dateCreated)
            self.commentArray.append(captionComment)
        }
        DataService.instance.downloadComments(postID: post.postID) { (returnedComments) in
            self.commentArray.append(contentsOf: returnedComments)
        }
        
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
    
    func addComment() {
        guard let userID = currentUserID, let displayName = currentUserDisplayName else {return}
        DataService.instance.uploadComment(postID: post.postID, content: submissionText, displayName: displayName, userID: userID) { (success, returnedCommentID) in
            if success, let commentID = returnedCommentID {
                let newComment = CommentModel(commentID: commentID, userID: userID, username: displayName, content: submissionText, dateCreated: Date())
                self.commentArray.append(newComment)
                self.submissionText = "" //reset to empty
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
    
}

struct CommentsView_Previews: PreviewProvider {
    
    static let post = PostModel(postID: "asdf", userID: "asdf", username: "asdf", dateCreated: Date(), likeCount: 0, likedByUser: false)
    
    static var previews: some View {
        
        NavigationView {
            CommentsView(post: post)
        }
        .preferredColorScheme(.dark)
        
    }
}
