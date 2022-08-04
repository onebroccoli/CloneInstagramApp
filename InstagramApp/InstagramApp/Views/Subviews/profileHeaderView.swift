//
//  profileHeaderView.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/21/21.
//

import SwiftUI

struct profileHeaderView: View {
    @Binding var profileDisplayName: String
    @Binding var profileImage: UIImage
    @ObservedObject var postArray: PostArrayObject
    @Binding var profileBio: String
    
    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 10, content: {
            
            // MARK: PROFILE PICTURE
//            Image("dog1")
            Image(uiImage: profileImage)

                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(60)
            
            // MARK: USER NAME
            Text(profileDisplayName)
                .font(.largeTitle)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            // MARK: BIO
                //            Text("This is the area where the user can add a bio to their profile!")
            if profileBio != "" {
                Text(profileBio)
                    .font(.body)
                    .fontWeight(.regular)
                    .multilineTextAlignment(.center)
            }
            
            HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20, content: {
               
                // MARK: POSTS
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5, content: {
                    
                    
                    Text(postArray.postCountString) // directly watching the postcount
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 20, height: 2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("posts")
                        .font(.callout)
                        .fontWeight(.medium)
                    
                    
                })
                
                // MARK: LIKES
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 5, content: {
                    
                    
                    Text(postArray.likeCountString) // watch the like count
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
                    Capsule()
                        .fill(Color.gray)
                        .frame(width: 20, height: 2, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    Text("Likes")
                        .font(.callout)
                        .fontWeight(.medium)
                    
                    
                })
            })
        })
        .frame(maxWidth: .infinity)
        .padding()
        
        
    }
}

struct profileHeaderView_Previews: PreviewProvider {
    @State static var name: String = "Joe"
    @State static var image: UIImage = UIImage(named: "dog1")!
    static var previews: some View {
        profileHeaderView(profileDisplayName: $name, profileImage: $image, postArray: PostArrayObject(shuffled: false), profileBio: $name)
            .previewLayout(.sizeThatFits)
    }
}
