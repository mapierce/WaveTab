//
//  WaveTabBarPresenterBase.swift
//  WaveTab
//
//  Created by Matthew Pierce on 15/05/2019.
//

import Foundation

class WaveTabBarPresenterBase: WaveTabBarPresenter {
    
    unowned let view: WaveTabBarProtocol
    
    // MARK: - Initialization
    
    init(view: WaveTabBarProtocol) {
        self.view = view
    }
    
    // MARK: - WaveTabBarPresent functions
    
    func viewDidAppear() {
        view.setupCurve()
    }
    
}
