//
//  WaveTabBarPresenterBase.swift
//  WaveTab
//
//  Created by Matthew Pierce on 15/05/2019.
//

import Foundation

class WaveTabBarPresenterBase: WaveTabBarPresenter {
    
    private struct Constants {
    
        static let smallRadius: Float = 25
        static let bigRadius: Float = 30
        static let smallCircle: Float = 47
        static let bigCircle: Float = 57
        static let animationDuration: TimeInterval = 0.2
        
    }

    unowned let view: WaveTabBarProtocol
    private var isPortrait = true
    
    // MARK: - Initialization
    
    init(view: WaveTabBarProtocol) {
        self.view = view
    }
    
    // MARK: - WaveTabBarPresent functions
    
    func viewDidLoad() {
        view.disableTransparentTabBar()
    }
    
    func viewDidAppear(with portraitOrientation: Bool) {
        isPortrait = portraitOrientation
        view.setupTabBarTags()
        view.setupCurve(isPortrait ? Constants.bigRadius : Constants.smallRadius)
        view.setupCircle(isPortrait ? Constants.bigCircle : Constants.smallCircle)
        view.setupImageView((isPortrait ? Constants.bigCircle : Constants.smallCircle) / 2)
        view.setupTabBarStyling()
    }
    
    func viewDidRotate(with portraitOrientation: Bool, at index: Int) {
        isPortrait = portraitOrientation
        view.updateCircleSize(isPortrait ? Constants.bigCircle : Constants.smallCircle)
        view.updateImageViewSize((isPortrait ? Constants.bigCircle : Constants.smallCircle) / 2)
        view.moveCurve(to: index, with: isPortrait ? Constants.bigRadius : Constants.smallRadius)
        view.moveCircle(with: Constants.animationDuration, and: isPortrait ? Constants.bigRadius : Constants.smallRadius)
    }
    
    func tabBarDidSelectItem(with tag: Int) {
        view.moveCurve(to: tag, with: isPortrait ? Constants.bigRadius : Constants.smallRadius)
        view.moveCircle(with: Constants.animationDuration, and: isPortrait ? Constants.bigRadius : Constants.smallRadius)
    }
    
    func moveCircleComplete() {
        view.updateImageView()
    }
    
}
