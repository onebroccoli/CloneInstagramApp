//
//  PostModel.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/18/21.
//

import Foundation
import SwiftUI
//set up post model, need to add post model into post view
struct PostModel: Identifiable, Hashable {
    var id = UUID()
    var postID: String //ID for the post in database
    var userID: String //ID for the user in database
    var username: String //username for user in database
    var caption: String? //caption -optional
    var dateCreated: Date //date post created
    var likeCount: Int //like count
    var likedByUser: Bool //liked by current user
    
    //complete a tashable
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
