//
//  DetailViewController.swift
//  WaveTab_Example
//
//  Created by Matthew Pierce on 12/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let isInMoreView = tabBarController?.moreNavigationController.viewControllers.contains(self) ?? false
        navigationController?.setNavigationBarHidden(isInMoreView, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}
