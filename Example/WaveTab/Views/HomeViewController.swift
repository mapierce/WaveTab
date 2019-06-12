//
//  HomeViewController.swift
//  WaveTab_Example
//
//  Created by Matthew Pierce on 12/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
//        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
}
