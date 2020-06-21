//
//  AppCoordinator.swift
//  Open-GitHub
//
//  Created by Aleksander Logozinsky on 21.06.2020.
//  Copyright © 2020 Aleksander Logozinsky. All rights reserved.
//

import UIKit

class AppCoordinator: BaseCoordinator {
    
    init(window: UIWindow) {
        self.window = window
    }
    
    private let window: UIWindow
    private let navigationController: UINavigationController = {
        let navigationController = UINavigationController()
        return navigationController
    }()
    
    override func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        let searchCoordinator = SearchCoordinator(navigationController: navigationController)
        add(coordinator: searchCoordinator)
        
        searchCoordinator.start()
    }
     
}
