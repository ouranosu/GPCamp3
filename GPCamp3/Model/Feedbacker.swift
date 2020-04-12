//
//  Feedbacker.swift
//  GPCamp3
//
//  Created by work on 2019/12/31.
//  Copyright © 2019 Masahiro Okura. All rights reserved.
//

import UIKit
import Foundation

struct Feedbacker {
    
    static func notice(type: UINotificationFeedbackGenerator.FeedbackType){
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
    
    static func impact(type: UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator()
        generator.prepare()
        generator.impactOccurred()
    }
    
    
}


