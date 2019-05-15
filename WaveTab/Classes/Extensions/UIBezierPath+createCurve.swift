//
//  UIBezierPath+createCurve.swift
//  WaveTab
//
//  Created by Matthew Pierce on 15/05/2019.
//

import UIKit

extension UIBezierPath {
    
    class func createCurve(at center: CGFloat, radius curve: CGFloat, on tabBar: UITabBar) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: center - (curve * 2), y: 0))
        path.addQuadCurve(to: CGPoint(x: center - curve, y: curve / 2), controlPoint: CGPoint(x: center - curve - radius / 7.5, y: 0))
        path.addCurve(to: CGPoint(x: center + curve, y: curve / 2),
                      controlPoint1: CGPoint(x: center - curve + curve / 4, y: radius + radius / 2),
                      controlPoint2: CGPoint(x: center + curve - curve / 4, y: radius + radius / 2))
        path.addQuadCurve(to: CGPoint(x: center + (curve * 2), y: 0), controlPoint: CGPoint(x: center + curve + curve / 7.5, y: 0))
        path.addLine(to: CGPoint(x: tabBar.bounds.width, y: 0))
        path.addLine(to: CGPoint(x: tabBar.bounds.width, y: tabBar.bounds.height))
        path.addLine(to: CGPoint(x: 0, y: tabBar.bounds.height))
        path.close()
        return path
    }
    
}
