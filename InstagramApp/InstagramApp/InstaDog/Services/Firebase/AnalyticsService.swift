//
//  AnalyticsService.swift
//  InstagramApp
//
//  Created by Sophia Zhu on 8/28/21.
//

import Foundation
import FirebaseAnalytics

class AnalyticsService {
    static let instance = AnalyticsService()
    
    func likePostDoubleTap() {
        Analytics.logEvent("like_double_tap", parameters: nil)
    }
    
    func likePostHeartPressed() {
        Analytics.logEvent("like_heart_clicked", parameters: ["name":"test"])
    }
}


