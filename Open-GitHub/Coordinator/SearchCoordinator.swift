//
//  SearchCoordinator.swift
//  Open-GitHub
//
//  Created by Aleksander Logozinsky on 20.06.2020.
//  Copyright © 2020 Aleksander Logozinsky. All rights reserved.
//

import UIKit

class SearchCoordinator: BaseCoordinator {
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private var navigationController: UINavigationController
    private var viewController = SearchViewController()
    
    override func start() {
        viewController.viewModelBuilder = {
            SearchViewModel(input: $0)
        }
        viewController.coordinator = self
        
        navigationController.viewControllers = [viewController]
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationController.navigationBar.prefersLargeTitles = true
        viewController.title = "Open GitHub"
        viewController.navigationItem.searchController = UISearchController(searchResultsController: nil)
        viewController.navigationItem.searchController?.searchBar.tintColor = .gitHubWhiteColor
        viewController.navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        if #available(iOS 13.0, *) {
            viewController.navigationItem.searchController?.searchBar.searchTextField.textColor = .gitHubWhiteColor
        } else {
            // Fallback on earlier versions
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gitHubWhiteColor]
        }
    }
    
    func openDetails(with model: GitHubRepository) {
        let coordinator = DetailsCoordinator(navigationController: navigationController, model: model)
        add(coordinator: coordinator)
        
        coordinator.start()
    }
    
}
