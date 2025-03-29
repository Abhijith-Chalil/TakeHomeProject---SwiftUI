//
//  HapticManager.swift
//  TakeHomeProject
//
//  Created by Abhijith Chalil on 25/03/25.
//

import Foundation
import SwiftUI

fileprivate final class HapticManager {
    
    static let shared = HapticManager()
    private let feedback = UINotificationFeedbackGenerator()
    
    private init() {}
    
    func trigger(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
        feedback.notificationOccurred(notification)
    }
    
}

func haptic(_ notification: UINotificationFeedbackGenerator.FeedbackType) {
    if UserDefaults.standard.bool(forKey: UserDefaultKeys.hapticsEnabled) {
        HapticManager.shared.trigger(notification)
    }
}
