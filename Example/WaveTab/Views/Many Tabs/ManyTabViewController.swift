//
//  ManyTabViewController.swift
//  WaveTab_Example
//
//  Created by Matthew Pierce on 17/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ManyTabViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let isInMoreNav = tabBarController?.moreNavigationController.viewControllers.contains(self) else { return }
        tabBarController?.navigationController?.setNavigationBarHidden(isInMoreNav, animated: false)
    }
    
}
