//
//  WaveTabBarController.swift
//  WaveTab
//
//  Created by Matthew Pierce on 15/05/2019.
//

import UIKit

class WaveTabBarController: UITabBarController, WaveTabBarProtocol {
    
    private struct Constants {
        
        static let tabBarButtonType = "UITabBarButton"
        static let radiusSize: CGFloat = 30
        static let waveColor: CGColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1).cgColor
        
    }
    
    var presenter: WaveTabBarPresenter!
    private var waveCurve: UIBezierPath
    
    private let waveSubLayer: CAShapeLayer = {
        let subLayer = CAShapeLayer()
        subLayer.fillColor = Constants.waveColor
        return subLayer
    }()
    
    private lazy var tabBarItems: [UIView] = {
        return tabBar.subviews.filter { String(describing: type(of: $0)) == Constants.tabBarButtonType }
    }()
    
    // MARK: - Lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        presenter = WaveTabBarPresenterBase(view: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - WaveTabBarProtocol functions
    
    func setupCurve() {
        let path = UIBezierPath.createCurve(at: tabBarItems[selectedIndex].center.x, radius: Constants.radiusSize, on: tabBar)
        waveSubLayer.path = path.cgPath
        tabBar.layer.insertSublayer(waveSubLayer, above: tabBar.layer.sublayers?.first)
    }
    
}
