//
//  HomeViewController.swift
//  WaveTab_Example
//
//  Created by Matthew Pierce on 19/06/2019.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private struct Consants {
        
        static let someStoryboardName = "Some"
        static let manyStoryboardName = "Many"
        
    }
    
    // MARK: - View lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Actions
    
    @IBAction private func showSomeTabsButtonTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: Consants.someStoryboardName, bundle: nil).instantiateInitialViewController()!
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func showManyTabsButtonTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: Consants.manyStoryboardName, bundle: nil).instantiateInitialViewController()!
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction private func showCustomTabsButtonTapped(_ sender: Any) {
        let vc = CustomTabBarController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
