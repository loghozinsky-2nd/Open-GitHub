//
//  SearchViewModel.swift
//  Open-GitHub
//
//  Created by Aleksander Logozinsky on 20.06.2020.
//  Copyright © 2020 Aleksander Logozinsky. All rights reserved.
//-

import RxSwift
import RxCocoa

protocol SearchViewPresenteble {
    typealias Builder = (Input) -> SearchViewPresenteble
    typealias Input = (
        searchText: Driver<String>,
        ()
    )
    typealias Output = (
        repositories: Observable<[GitHubRepository]>,
        ()
    )
    
    var input: Input { get }
    var output: Output { get }
}

class SearchViewModel: SearchViewPresenteble {
    
    var input: Input
    var output: Output
    
    let disposeBag = DisposeBag()
    
    init(input: SearchViewPresenteble.Input) {
        self.input = input
        self.output = Output(
            repositories: Repository.shared.gitHubRepositories.asObservable().catchErrorJustReturn([]),
            ()
        )
        
        process()
    }
    
    private func process() {
        input.searchText
            .debounce(.milliseconds(500))
            .distinctUntilChanged()
            .drive(onNext: { [weak self] (searchText) in
                if searchText.count > 1 {
                    self?.fetchRepositories(query: searchText)
                } else {
                    Repository.shared.gitHubRepositories.accept([])
                }
            })
            .disposed(by: disposeBag)
        
        output.repositories
            .subscribe { (event) in
            }
        .   disposed(by: disposeBag)
    }
    
    private func fetchRepositories(query: String, sortBy: SortByType = .stars) {
        Repository.shared.getRepository(query: query, sortBy: .stars)
    }
    
}
