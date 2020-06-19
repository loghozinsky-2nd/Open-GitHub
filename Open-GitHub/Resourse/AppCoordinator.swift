//
//  AppCoordinator.swift
//  Open-GitHub
//
//  Created by Aleksander Logozinsky on 19.06.2020.
//  Copyright © 2020 Aleksander Logozinsky. All rights reserved.
//

import UIKit

class AppCoordinator {
    
    init(window: UIWindow) {
        self.window = window
        
        start()
    }
    
    private let window: UIWindow
    
    func start() {
        let viewController = ViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
}
