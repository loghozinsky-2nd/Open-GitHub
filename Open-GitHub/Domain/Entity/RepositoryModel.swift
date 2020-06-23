//
//  RepositoryModel.swift
//  Open-GitHub
//
//  Created by Aleksander Logozinsky on 20.06.2020.
//  Copyright © 2020 Aleksander Logozinsky. All rights reserved.
//

import Foundation

enum SortByType: String {
    case stars
    case forks
    case helpWantedIssues = "help-wanted-issues"
    case updated
    case bestMatch = ""
}

struct GitHubSearchRepositoriesResponse: Decodable {
    let totalCount: Int
    let items: [GitHubRepository]
    
    private enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }
}

struct GitHubRepository: Decodable {
    let owner: GitHubUser
    
    let id: Int
    let fullName: String?
    let description: String?
    let url: URL
    let createdAt: String
    let updatedAt: String
    let stargazersCount: Int
    let forksCount: Int
    let watchersCount: Int
    let language: String?
    let score: Double
    
    private enum CodingKeys: String, CodingKey {
        case owner
        case id
        case fullName = "full_name"
        case description
        case url = "html_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case forksCount = "forks_count"
        case score
    }
    
    init(from entity: GitHubRepositoryEntity) {
        self.owner = GitHubUser()
//        self.owner = .init(from: entity.owner)
        self.id = Int(entity.repositoryId)
        self.fullName = entity.full_name
        self.description = entity.description_
        self.url = entity.html_url ?? URL(string: "https://github.com/")!
        self.createdAt = entity.created_at ?? ""
        self.updatedAt = entity.updated_at ?? ""
        self.stargazersCount = Int(entity.stargazers_count)
        self.watchersCount = Int(entity.watchers_count)
        self.language = entity.language
        self.forksCount = 0
        self.score = entity.score
    }
    
}

struct GitHubUser: Decodable {
    let login: String
    let id: Int
    let avatarUrl: URL?
    let url: URL?
    let type: String
    
    private enum CodingKeys: String, CodingKey {
        case login
        case id
        case avatarUrl = "avatar_url"
        case url
        case type
    }
    
    init() {
        self.login = String()
        self.id = 0
        self.avatarUrl = nil
        self.url = nil
        self.type = String()
    }
    
    init(login: String, id: Int, avatarUrl: URL?, url: URL?, type: String) {
        self.login = login
        self.id = id
        self.avatarUrl = avatarUrl
        self.url = url
        self.type = type
    }
    
    init(from entity: GitHubUserEntity) {
        self.login = entity.login ?? ""
        self.id = Int(entity.userId)
        self.avatarUrl = entity.avatarUrl ?? URL(string: "https://github.com/")
        self.url = entity.userUrl ?? URL(string: "https://github.com/")
        self.type = entity.type ?? ""
    }
}
