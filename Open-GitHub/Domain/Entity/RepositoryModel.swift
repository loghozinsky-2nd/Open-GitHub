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
    let updatedAt: String?
    let stargazersCount: Int
    let watchersCount: Int
    let language: String?
    let forksCount: Int
    let score: Double
    
    private enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case description
        case url = "html_url"
        case owner
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case forksCount = "forks_count"
        case score
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
}
