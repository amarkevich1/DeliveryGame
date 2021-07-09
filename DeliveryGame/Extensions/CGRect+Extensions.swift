//
//  CGRect+Extensions.swift
//  DeliveryGame
//
//  Created by aleksey on 9.07.21.
//

import UIKit

extension CGRect {
    func randomPointInRect() -> CGPoint {
        let origin = self.origin
        return CGPoint(x: CGFloat(arc4random_uniform(UInt32(self.width))) + origin.x, y: CGFloat(arc4random_uniform(UInt32(self.height))) + origin.y)
    }
}
