//
//  GradientBackgroundLayer.swift
//  MobiTalksTDDiOS
//
//  Created by Victor Magalhaes on future.
//  Copyright © 2018 MobiTalks. All rights reserved.
//

import Foundation
import UIKit

class GradientBackgroundLayer: CAGradientLayer {
    
    override init() {
        super.init()
        setupLayer()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) { return nil }
    
    private func setupLayer() {
        frame = UIScreen.main.bounds
        colors = [#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor, #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor]
        startPoint = CGPoint(x: 0.5, y: 0.0)
        endPoint = CGPoint(x: 1.0, y: 1.0)
    }
}
