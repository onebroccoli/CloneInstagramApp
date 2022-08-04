//
//  BrowseView.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/19/21.
//

import SwiftUI

struct BrowseView: View {
    var posts: PostArrayObject
    var body: some View {
        ScrollView(/*@START_MENU_TOKEN@*/.vertical/*@END_MENU_TOKEN@*/, showsIndicators: false, content: {
            CarouselView()
            ImageGridView(posts: posts)
        })
        .navigationBarTitle("Browse")
        .navigationBarTitleDisplayMode(.inline)
//        .navigationBarTitleDisplayMode(.large)


    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BrowseView(posts: PostArrayObject(shuffled: true))
        }
    }
}
