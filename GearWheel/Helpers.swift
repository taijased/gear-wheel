//
//  Helpers.swift
//  GearWheel
//
//  Created by Максим Спиридонов on 25.03.2021.
//

import UIKit

public extension CGPoint {
    static func + (left: CGPoint, right: CGPoint) -> CGPoint {
      return CGPoint(x: left.x + right.x, y: left.y + right.y)
    }
    
    static func - (left: CGPoint, right: CGPoint) -> CGPoint {
      return CGPoint(x: left.x - right.x, y: left.y - right.y)
    }
    
    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
      return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }
    
    static func *= (point: inout CGPoint, scalar: CGFloat) {
      point = point * scalar
    }
    
    
}
