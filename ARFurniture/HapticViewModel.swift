//
//  HapticViewModel.swift
//  ARFurniture
//
//  Created by KANISHK VIJAYWARGIYA on 20/01/22.
//

import SwiftUI

class HapticViewModel: ObservableObject {
    func haptic(type: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}
