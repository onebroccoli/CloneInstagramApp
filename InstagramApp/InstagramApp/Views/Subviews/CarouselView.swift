//
//  CarouselView.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/19/21.
//

import SwiftUI

struct CarouselView: View {
    @State var selection: Int = 1
    let maxCount: Int = 8
    @State var timerAdded: Bool = false
    var body: some View {
        TabView(selection: $selection,
                content:  {
                    ForEach(1..<maxCount) {count in
                        Image("dog\(count)")
                        .resizable()
                        .scaledToFill()
                        .tag(count)
                    }
//                    Image("dog1")
//                        .resizable()
//                        .scaledToFill()
//                        .tag(0)
                   
                })
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 300)
            .animation(.default)
            .onAppear(perform: {
                if !timerAdded {
                    addTimer()
                }
            })
//            .background(Color.red)
        
    }
    
    func addTimer() {
        timerAdded = true
        let timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) {(timer) in
            
            if selection == (maxCount - 1) {
                selection = 1
            } else {
                selection += 1

            }
            
        }
        timer.fire()
        
    }
}

struct CarouselView_Previews: PreviewProvider {
    static var previews: some View {
        CarouselView()
            .previewLayout(.sizeThatFits)
    }
}
