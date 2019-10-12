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
        static let circleAnimationDuration: TimeInterval = 0.2
        static let waveAnimationDuration: TimeInterval = Constants.circleAnimationDuration * 2
        static let showHideAnimationDuration: TimeInterval = 0.3
        
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
        view.showTabBar(false, animated: false, over: Constants.showHideAnimationDuration)
    }
    
    func viewDidAppear(portrait portraitOrientation: Bool) {
        isPortrait = portraitOrientation
        view.showTabBar(true, animated: true, over: Constants.showHideAnimationDuration)
        view.setupTabBarTags()
        view.setupCurve(isPortrait ? Constants.bigRadius : Constants.smallRadius)
        view.setupCircle(isPortrait ? Constants.bigCircle : Constants.smallCircle)
        view.setupImageView((isPortrait ? Constants.bigCircle : Constants.smallCircle) / 2)
        view.setupTabBarColoring()
        view.setupTabBarBackground()
    }
    
    func viewDidRotate(portrait portraitOrientation: Bool, at index: Int) {
        isPortrait = portraitOrientation
        view.updateCircleSize(isPortrait ? Constants.bigCircle : Constants.smallCircle)
        view.updateImageViewSize((isPortrait ? Constants.bigCircle : Constants.smallCircle) / 2)
        view.moveCurve(with: Constants.waveAnimationDuration,
                       to: index,
                       with: isPortrait ? Constants.bigRadius : Constants.smallRadius)
        view.moveCircle(over: Constants.circleAnimationDuration,
                        offset: isPortrait ? Constants.bigRadius : Constants.smallRadius,
                        down: true)
    }
    
    func tabBarDidSelectItem(with tag: Int) {
        view.moveCurve(with: Constants.waveAnimationDuration,
                       to: tag,
                       with: isPortrait ? Constants.bigRadius : Constants.smallRadius)
        view.moveCircle(over: Constants.circleAnimationDuration,
                        offset: isPortrait ? Constants.bigRadius : Constants.smallRadius,
                        down: true)
    }
    
    func moveCircleComplete(down movingDown: Bool) {
        view.updateImageView()
        view.updateCircleCenter()
        if movingDown {
            view.moveCircle(over: Constants.circleAnimationDuration,
                            offset: isPortrait ? Constants.bigRadius : Constants.smallRadius,
                            down: false)
        }
    }
    
}
