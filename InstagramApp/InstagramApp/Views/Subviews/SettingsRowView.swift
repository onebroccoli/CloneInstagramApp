//
//  SettingsRowView.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/21/21.
//

import SwiftUI

struct SettingsRowView: View {
    var leftIcon: String
    var text: String
    var color: Color
    
    var body: some View {
        HStack {
            
            ZStack{
                RoundedRectangle(cornerRadius: 8, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .fill(color)
                    Image(systemName: leftIcon)
                        .font(.title3)
                        .foregroundColor(.white)
                
                
            }
            .frame(width: 36, height: 36, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Text(text)
                .foregroundColor(.primary)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.headline)
                .foregroundColor(.primary)
        }
    }
}

struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(leftIcon: "heart.fill", text: "Row Title", color: .red)
            .previewLayout(.sizeThatFits)
    }
}
