//
//  ContentView.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/18/21.
//

import SwiftUI



struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @AppStorage(CurrentUserDefaults.userID) var currentUserID: String?
//    var currentUserID: String? = nil
    @AppStorage(CurrentUserDefaults.displayName) var currentUserDisplayName: String?
    
    let feedPosts = PostArrayObject(shuffled: false)
    let browsePosts = PostArrayObject(shuffled: true)
    var body: some View {
//        Text("Hello, everyone!")
//            .padding()
        TabView {
//            Text("Screen 1")
            NavigationView {
                FeedView(posts: feedPosts, title: "Feed")
            }
                .tabItem{
                    Image(systemName: "book.fill")
                    Text("Feed")
                }
            
            NavigationView {
                BrowseView(posts: browsePosts)
                
            }
                    .tabItem{
                        Image(systemName: "magnifyingglass")
                        Text("Browse")
                    }
            
            
            UploadView()
                .tabItem{
                    Image(systemName: "square.and.arrow.up.fill")
                    Text("Upload")
                }
            
            ZStack {
                if let userID = currentUserID, let displayName = currentUserDisplayName {
                    NavigationView{
                        profileView(isMyProfile: true, profileDisplayName: displayName, profileUserID: userID, posts: PostArrayObject(userID: userID))
                    }
                }  else {
                    SignUpView()
                    
                }
                
            }
            
           
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("Profile")
                }
        }
        .accentColor(colorScheme == .light ? Color.MyTheme.purpleColor : Color.MyTheme.yellowColor)
        
        
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            
    }
}
