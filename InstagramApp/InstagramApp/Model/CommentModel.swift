//
//  CommentModel.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/19/21.
//

import Foundation
import SwiftUI

struct CommentModel: Identifiable, Hashable {
    
    var id = UUID()
    var commentID: String // ID for the comment in the database
    var userID: String //ID for the user in the database
    var username: String //username in the database
    var content: String //Actual commment text
    var dateCreated: Date
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
