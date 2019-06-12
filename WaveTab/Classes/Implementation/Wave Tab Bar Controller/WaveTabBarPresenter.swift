//
//  WaveTabBarPresenter.swift
//  WaveTab
//
//  Created by Matthew Pierce on 15/05/2019.
//

import Foundation

protocol WaveTabBarPresenter: class {
    
    var view: WaveTabBarProtocol { get }
    
    func viewDidLoad()
    
    func viewDidAppear(portrait portraitOrientation: Bool)
    
    func viewDidRotate(portrait portraitOrientation: Bool, at index: Int)
    
    func tabBarDidSelectItem(with tag: Int)
    
    func moveCircleComplete(down movingDown: Bool)
    
}
