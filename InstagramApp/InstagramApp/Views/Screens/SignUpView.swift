//
//  SignUpView.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/22/21.
//

import SwiftUI

struct SignUpView: View {
    
    @State var showOnboarding: Bool = false

    var body: some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 20,
            
            content: {
                Spacer()
                
                Image("logo.transparent")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            Text("You are not signed in! 🐶")
                .font(.largeTitle)
                .fontWeight(.bold)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
                .foregroundColor(Color.MyTheme.purpleColor)
            
            Text("Click the button below to create an account and join the fun!")
                .font(.headline)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.MyTheme.purpleColor)
            
            Button(action: {
                showOnboarding.toggle()
            }, label: {
                Text("Sign in / Sign up".uppercased())
                         .font(.headline)
                         .fontWeight(.bold)
                         .padding()
                         .frame(maxWidth: .infinity)
                         .frame(height: 60)
                         .background(Color.MyTheme.purpleColor)
                         .cornerRadius(12)
                         .shadow(radius: 12)
            })
            .accentColor(Color.MyTheme.yellowColor)
          
            Spacer()
            Spacer()
        })
            .padding(.all, 40)
            .background(Color.MyTheme.yellowColor)
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            .fullScreenCover(isPresented: $showOnboarding, content: {
                OnboardingView()
            })
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
        
    }
}
