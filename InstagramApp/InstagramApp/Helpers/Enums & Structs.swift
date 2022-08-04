//
//  Enums & Structs.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/25/21.
//

import Foundation

struct DatabaseUserField { //fields within the user document in database
   static let displayName = "display_name"
    static let email = "email"
    static let providerID =  "provider_id"
    static let provider = "provider"
    static let userID = "user_id"
    static let bio = "bio"
    static let dateCreated = "date_created"

}

struct DatabasePostField { // fields within Post Document in Database
    static let postID = "post_id"
    static let userID = "user_id"
    static let displayName = "display_name"
    static let caption = "caption"
    static let dateCreated = "date_created"
    static let likeCount = "like_count" // Int
    static let likedBy = "like_by" // array of userid that like the post
    static let comments = "comments" // subcollection
}

struct DatabaseCommentsField { //Field within the comment subcollection of a post document
    static let commentID = "comment_id"
    static let displayName = "display_name"
    static let userID = "user_id"
    static let content = "content"
    static let dateCreated = "date_created"

}


struct DatabaseReportField { // Fields within Report Document in Database
    static let content = "content"
    static let postID = "post_id"
    static let dateCreated = "date_created"
    
    
}

struct CurrentUserDefaults { // Fields for UserDefaults saved within app
    
    static let displayName = "display_name"
    static let bio = "bio"
    static let userID = "user_id"
    
}

enum SettingsEditTextOption {
    case displayName
    case bio
}

