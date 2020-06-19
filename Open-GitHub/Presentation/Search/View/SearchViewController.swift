//
//  SearchViewController.swift
//  Open-GitHub
//
//  Created by Aleksander Logozinsky on 19.06.2020.
//  Copyright © 2020 Aleksander Logozinsky. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: ViewController {
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        
        return tableView
    }()
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = .white
        
        return activityIndicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupNavigationBar()
        setupLayout(for: tableView, activityIndicator)
        setupBinding()
    }
    
    private func setupNavigationBar() {
        title = "Open GitHub"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = UISearchController(searchResultsController: nil)
        navigationItem.searchController?.searchBar.tintColor = .gitHubWhiteColor
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        if #available(iOS 13.0, *) {
            navigationItem.searchController?.searchBar.searchTextField.textColor = .gitHubWhiteColor
        } else {
            // Fallback on earlier versions
            UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gitHubWhiteColor]
        }
    }
    
    private func setupLayout(for views: UIView ...) {
        view.addSubviews(views)
        
        tableView.fillSuperview()
        activityIndicator.anchor(centerY: tableView.centerYAnchor, centerX: tableView.centerXAnchor)
    }
    
    private func setupBinding() {
        
    }
    

}

