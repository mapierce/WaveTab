//
//  SomeTabViewController.swift
//  WaveTab_Example
//
//  Created by Matthew Pierce on 19/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class SomeTabViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
