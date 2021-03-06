//
//  AppDelegate.swift
//  WaveTab
//
//  Created by Matthew Pierce on 05/02/2019.
//  Copyright (c) 2019 Matthew Pierce. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private struct Constants {
        
        static let homeStoryboard = "Home"
        
    }

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIStoryboard.init(name: Constants.homeStoryboard, bundle: nil).instantiateInitialViewController()!
        window?.rootViewController = vc
        window?.makeKeyAndVisible()
        return true
    }


}

