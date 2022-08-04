//
//  PostArrayObject.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/18/21.
//

import Foundation

class PostArrayObject: ObservableObject {
    @Published var dataArray = [PostModel]() //data array of PostModel
    @Published var postCountString = "0"
    @Published var likeCountString = "0"
    
//    init() {
//        print ("FETCH FROM DATABASE HERE")
//        
//        let post1 = PostModel(postID: "", userID: "", username: "Joe Green", caption: "This is a caption", dateCreated: Date(), likeCount: 0, likedByUser: false)
//        let post2 = PostModel(postID: "", userID: "", username: "Jessica",  caption: nil, dateCreated: Date(), likeCount: 0, likedByUser: false)
//        let post3 = PostModel(postID: "", userID: "", username: "Emily", caption: "This is a really long caption hahahaahha " , dateCreated: Date(), likeCount: 0, likedByUser: false)
//        let post4 = PostModel(postID: "", userID: "", username: "Christina", caption: nil, dateCreated: Date(), likeCount: 0, likedByUser: false)
//        
//        self.dataArray.append(post1)
//        self.dataArray.append(post2)
//        self.dataArray.append(post3)
//        self.dataArray.append(post4)
//
//    }
    
    /// USED FOR SINGLE POST SELECTION
    init(post: PostModel) {
        self.dataArray.append(post)
    }
    
    /// USED FOR GETTING POSTS FOR USER PROFILE
    init(userID: String) {
        
        //
        print("GET POSTS FOR USER ID \(userID)")
        DataService.instance.downloadPostForUser(userID: userID) { (returnedPosts) in
            let sortedPosts = returnedPosts.sorted { (post1, post2) -> Bool in
                return post1.dateCreated > post2.dateCreated //most recent post show first
            }
            self.dataArray.append(contentsOf: sortedPosts)
            self.updateCounts()
        }
    }
    
    /// USED FOR FEED
    init(shuffled: Bool) { //choose to shuffle the post or not
        print("GET POSTS FOR FEED. SHUFFLED: \(shuffled)")
        DataService.instance.downloadPostsForFeed { (returnedPosts) in
            if shuffled {
                let shuffledPosts = returnedPosts.shuffled()
                self.dataArray.append(contentsOf: shuffledPosts)
            } else {
                self.dataArray.append(contentsOf: returnedPosts)
            }
        }
    }
    
    func updateCounts() {
        //post count
        self.postCountString = "\(self.dataArray.count)"
        
        // like count
        print(dataArray)
        let likeCountArray = dataArray.map { (existingPost) -> Int in
            return existingPost.likeCount
        }
        print(likeCountArray)
        let sumOfLikeCountArray = likeCountArray.reduce(0, +)
        self.likeCountString = "\(sumOfLikeCountArray)"
    }
    
}
