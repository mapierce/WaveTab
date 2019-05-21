//
//  WaveTabBarProtocol.swift
//  WaveTab
//
//  Created by Matthew Pierce on 15/05/2019.
//

import Foundation

protocol WaveTabBarProtocol: class {
    
    func setupTabBarTags()
    
    func setupCurve(_ radius: Float)
    
    func setupCircle(_ width: Float)
    
    func setupTabBarStyling()
    
    func setupImageView(_ center: Float)
    
    func updateImageView()
    
    func moveCurve(to index: Int, with radius: Float)
    
    func moveCircle(with duration: TimeInterval, and circleOffset: Float)
    
}
