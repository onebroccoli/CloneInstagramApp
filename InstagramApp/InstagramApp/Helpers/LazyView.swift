//
//  LazyView.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/27/21.
//

import Foundation
import SwiftUI

struct LazyView<Content: View>: View {
     
    var content: () -> Content
    
    var body: some View {
        self.content()
        
    }
}
