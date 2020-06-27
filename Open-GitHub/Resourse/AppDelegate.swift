//
//  AppDelegate.swift
//  Open-GitHub
//
//  Created by Aleksander Logozinsky on 19.06.2020.
//  Copyright © 2020 Aleksander Logozinsky. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        AppCoordinator(window: window).start()
        
        return true
    }
}

