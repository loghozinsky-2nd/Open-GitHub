//
//  DetailsCoordinator.swift
//  Open-GitHub
//
//  Created by Aleksander Logozinsky on 20.06.2020.
//  Copyright © 2020 Aleksander Logozinsky. All rights reserved.
//

import UIKit

class DetailsCoordinator: BaseCoordinator {
    
    init(navigationController: UINavigationController, model: GitHubRepository) {
        self.navigationController = navigationController
        self.model = model
    }
    
    private var navigationController: UINavigationController
    private var viewController = DetailsViewController()
    var model: GitHubRepository
    
    override func start() {
        viewController.viewModelBuilder = {
            DetailsViewModel(input: $0)
        }
        viewController.coordinator = self
        
        navigationController.pushViewController(viewController, animated: true)
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        viewController.title = "Details of Repository"
    }
    
}
