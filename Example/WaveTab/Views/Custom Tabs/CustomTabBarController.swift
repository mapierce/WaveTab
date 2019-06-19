//
//  CustomTabBarController.swift
//  WaveTab_Example
//
//  Created by Matthew Pierce on 17/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import WaveTab

class CustomTabBarController: WaveTabBarController {
    
    private struct Constants {
        
        static let storyboardName = "Custom"
        static let rocketTab = "Rocket"
        static let mountainTab = "Mountain"
        static let tvTab = "TV"
        static let oneView = "oneView"
        static let twoView = "twoView"
        static let threeView = "threeView"
        
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let oneVc = createTabViewController(withIdentifier: Constants.oneView, tabTitle: Constants.rocketTab)
        let twoVc = createTabViewController(withIdentifier: Constants.twoView, tabTitle: Constants.mountainTab)
        let threeVc = createTabViewController(withIdentifier: Constants.threeView, tabTitle: Constants.tvTab)
        viewControllers = [oneVc, twoVc, threeVc]
    }
    
    // MARK: - Private functions
    
    private func createTabViewController(withIdentifier identifier: String, tabTitle title: String) -> UIViewController {
        let storyboard = UIStoryboard(name: Constants.storyboardName, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier)
        vc.tabBarItem = UITabBarItem(title: title, image: UIImage(named: title)!, tag: 0)
        return vc
    }
    
}
