//
//  Repository.swift
//  Open-GitHub
//
//  Created by Aleksander Logozinsky on 20.06.2020.
//  Copyright © 2020 Aleksander Logozinsky. All rights reserved.
//

import RxSwift
import RxCocoa

class Repository {
    
    private init() {}
    
    static let shared = Repository()
    
    var gitHubRepositories = BehaviorRelay<[GitHubRepository]>(value: [])
    
    // MARK: - GitHubRepositories
    func getRepository(query: String, sortBy: SortByType) {
        APIService.shared.getRepositories(query: query, sortBy: sortBy.rawValue) { [weak self] (response) in
            self?.gitHubRepositories.accept(response.items)
        }
    }
    
}
