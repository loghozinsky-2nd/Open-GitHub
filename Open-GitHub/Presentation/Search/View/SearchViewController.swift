//
//  SearchViewController.swift
//  Open-GitHub
//
//  Created by Aleksander Logozinsky on 19.06.2020.
//  Copyright © 2020 Aleksander Logozinsky. All rights reserved.
//

import UIKit
import RxSwift

class SearchViewController: ViewController {
    
    let collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.itemSize = .init(width: UIScreen.main.bounds.width - 32, height: 126)
            
            return layout
        }()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = .init(top: 16, left: 0, bottom: 16, right: 0)
        collectionView.keyboardDismissMode = .onDrag
        
        return collectionView
    }()
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = .white
        
        return activityIndicator
    }()
    lazy var searchBar: UISearchBar = {
        guard let searchBar = navigationItem.searchController?.searchBar else { fatalError("Search Controller should be initialized") }
        
        return searchBar
    }()
    
    private var viewModel: SearchViewPresenteble!
    var viewModelBuilder: SearchViewPresenteble.Builder!
    var coordinator: SearchCoordinator!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.reuseIdentifier)
        
        bindViewModel()
        
        setupLayout(for: collectionView, activityIndicator)
    }
    
    private func setupLayout(for views: UIView ...) {
        view.addSubviews(views)
        
        collectionView.backgroundColor = .gitHubWhiteColor
        
        collectionView.fillSuperview()
        activityIndicator.anchor(centerY: collectionView.centerYAnchor, centerX: collectionView.centerXAnchor)
    }
    
    private func bindViewModel() {
        viewModel = viewModelBuilder((
            searchText: searchBar.rx.text.orEmpty.asDriver(),
            ()
        ))
        
        viewModel.output.repositories
            .bind(to: collectionView.rx.items(
                cellIdentifier: SearchResultCollectionViewCell.reuseIdentifier,
                cellType: SearchResultCollectionViewCell.self)) { row, data, cell in
                    cell.configureWithData(data)
                }
            .disposed(by: disposeBag)
        
        collectionView
            .rx
            .modelSelected(GitHubRepository.self)
            .subscribe(onNext: { (model) in
                self.coordinator.openDetails(with: model)
            }).disposed(by: disposeBag)
    }
    

}
