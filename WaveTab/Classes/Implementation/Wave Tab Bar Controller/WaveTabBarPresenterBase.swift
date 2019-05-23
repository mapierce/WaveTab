//
//  WaveTabBarPresenterBase.swift
//  WaveTab
//
//  Created by Matthew Pierce on 15/05/2019.
//

import Foundation

class WaveTabBarPresenterBase: WaveTabBarPresenter {
    
    private struct Constants {
        
        static let radiusSize: Float = 30
        static let circleWidth: Float = 50.0
        
    }
    
    unowned let view: WaveTabBarProtocol
    
    // MARK: - Initialization
    
    init(view: WaveTabBarProtocol) {
        self.view = view
    }
    
    // MARK: - WaveTabBarPresent functions
    
    func viewDidAppear() {
        view.setupTabBarTags()
        view.setupCurve(Constants.radiusSize)
        view.setupCircle(Constants.circleWidth)
        view.setupTabBarStyling()
        view.setupImageView(Constants.circleWidth / 2)
    }
    
    func tabBarDidSelectItem(with tag: Int) {
        view.moveCurve(to: tag, with: Constants.radiusSize)
        view.moveCircle(with: 0.2, and: Constants.radiusSize)
    }
    
    func moveCircleComplete() {
        view.updateImageView()
    }
    
}