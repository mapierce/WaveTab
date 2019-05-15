//
//  WaveTabBarController.swift
//  WaveTab
//
//  Created by Matthew Pierce on 15/05/2019.
//

import UIKit

class WaveTabBarController: UITabBarController, WaveTabBarProtocol {
    
    var presenter: WaveTabBarPresenter!
    
    // MARK: - Lifecycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        presenter = WaveTabBarPresenterBase(view: self)
    }
    
}
