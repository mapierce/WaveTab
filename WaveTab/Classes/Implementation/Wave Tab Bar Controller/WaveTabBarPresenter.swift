//
//  WaveTabBarPresenter.swift
//  WaveTab
//
//  Created by Matthew Pierce on 15/05/2019.
//

import Foundation

protocol WaveTabBarPresenter: class {
    
    var view: WaveTabBarProtocol { get }
    
    func viewDidAppear()
    
    func tabBarDidSelectItem(with tag: Int)
    
    func moveCircleComplete()
    
}
