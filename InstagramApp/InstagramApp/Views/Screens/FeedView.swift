//
//  FeedView.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/18/21.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var posts: PostArrayObject
    var title: String
    var body: some View {
        ScrollView(.vertical, showsIndicators: false, content: {
            LazyVStack { //move foreach into LazyVStack , only going to create the post as they come onto the screen.

                ForEach(posts.dataArray, id: \.self) { post in PostView(post: post, showHeaderAndFooter: true, addHeartAnimationToView: true)
                }
            }
            
            //load all the posts,
//            PostView()
        })
        .navigationBarTitle(title)
//        .navigationBarTitle("FEED VIEW") //add navigation bar when in navigation view
        .navigationBarTitleDisplayMode(.inline)
    }
}
//put FeedView() into navigation view
struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FeedView(posts: PostArrayObject(shuffled: false), title: "Feed Test")
        }
    }
}
