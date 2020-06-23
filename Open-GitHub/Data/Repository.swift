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
    var savedGitHubRepositories = BehaviorRelay<[GitHubRepository]>(value: [])
    
    // MARK: - GitHubRepositories
    func getRepository(query: String, sortBy: SortByType) {
        APIService.shared.getRepositories(query: query, sortBy: sortBy.rawValue) { [weak self] (response) in
            let items = response.items
            self?.gitHubRepositories.accept(items)
            
            CoreDataService.shared.delete(entityName: "GitHubRepositoryEntity") { () in
                CoreDataService.shared.save(items)
            }
        }
    }
    
    func getSavedGitHubRepository() {
        CoreDataService.shared.fetch { [weak self] (repositories) in
            let items = repositories.sorted {
                $0.stargazersCount > $1.stargazersCount
            }
            self?.gitHubRepositories.accept(items)
        }
    }
    
}
