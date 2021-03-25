//
//  GearWheelView.swift
//  GearWheel
//
//  Created by Максим Спиридонов on 25.03.2021.
//

import UIKit
import CoreGraphics

final class GearWheelView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let lineWidth: CGFloat = 2.0
    var radius: CGFloat = 60
    let triangleAlpha: CGFloat = 45
    
    
    func redraw(count: Int, height: CGFloat, radius: CGFloat) {
        self.radius = radius
        layer.sublayers?.removeAll()
        
        let lCircle = CGFloat.pi * 2 * radius
        let lGear = lCircle / CGFloat(count)
        let beta = lGear / radius
        
        if beta < CGFloat.pi / 2 {
         
            let p0: CGPoint = .init(x: self.bounds.width / 2, y: self.bounds.height / 2)
            for i in 0..<count {
                
                let angle1 = beta * CGFloat(i)
                let angle2 = beta * CGFloat(i + 1)
                let tetta = (angle1 + angle2) /  2
                
                let p1 = p0 + CGPoint(x: radius * cos(angle1), y: radius * sin(angle1))
                let p2 = p0 + CGPoint(x: radius * cos(angle2), y: radius * sin(angle2))
                let pI = p0 + CGPoint(x: (radius + height) * cos(tetta), y: (radius + height) * sin(tetta))

                let p1C = (pI - p1) * 0.5 + p1
                let p2C = (pI - p2) * 0.5 + p2
                
                drawLine(start: p1, end: p1C)
                drawLine(start: p2, end: p2C)

                
                //MARK: - так надо было?
                let linePath = UIBezierPath()
                linePath.move(to: p1C)
                linePath.addQuadCurve(to: p2C, controlPoint: pI)

                let lineLayer = CAShapeLayer()
                lineLayer.path = linePath.cgPath
                lineLayer.fillColor = UIColor.gray.cgColor
                lineLayer.strokeColor = UIColor.gray.cgColor
                lineLayer.lineWidth = 1

                layer.addSublayer(lineLayer)
                
                
                let freeform = UIBezierPath()
                freeform.move(to: p1)
                freeform.addLine(to: p1C)
                freeform.addLine(to: p2C)
                freeform.addLine(to: p2)
                freeform.addLine(to: p1)
                
                let freeformLayer = CAShapeLayer()
                freeformLayer.path = freeform.cgPath
                freeformLayer.fillColor = UIColor.gray.cgColor
                freeformLayer.strokeColor = UIColor.gray.cgColor
                layer.addSublayer(freeformLayer)
                
               
          
                                
            }
            
            drawCircle(point: p0, radius: radius, color: UIColor.gray)
            drawCircle(point: p0, radius: radius / 2, color: UIColor.white)
        }
        
    }
    
    
    
    func canDraw(count: Int, radius: CGFloat) -> Bool {
        let lCircle = CGFloat.pi * 2 * radius
        let lGear = lCircle / CGFloat(count)
        let beta = lGear / radius
        return beta < CGFloat.pi / 2
    }
    
    
    
    fileprivate func drawLine(start: CGPoint, end: CGPoint) {
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)

        let lineLayer = CAShapeLayer()
        lineLayer.path = linePath.cgPath
        lineLayer.strokeColor = UIColor.gray.cgColor
        lineLayer.fillColor = UIColor.gray.cgColor
        lineLayer.lineWidth = 1

        layer.addSublayer(lineLayer)
    }
    
    
    fileprivate func drawCircle(point: CGPoint, radius: CGFloat, color: UIColor) {
        let circlePath = UIBezierPath(arcCenter: point, radius: radius, startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)

        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = color.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 3

        layer.addSublayer(shapeLayer)
    }
    
}

