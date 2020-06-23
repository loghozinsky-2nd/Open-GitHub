//
//  GitHubRepositoryEntity+CoreDataProperties.swift
//  Open-GitHub
//
//  Created by Aleksander Logozinsky on 23.06.2020.
//  Copyright © 2020 Aleksander Logozinsky. All rights reserved.
//
//

import Foundation
import CoreData


extension GitHubRepositoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GitHubRepositoryEntity> {
        return NSFetchRequest<GitHubRepositoryEntity>(entityName: "GitHubRepositoryEntity")
    }

    @NSManaged public var created_at: String?
    @NSManaged public var description_: String?
    @NSManaged public var full_name: String?
    @NSManaged public var html_url: URL?
    @NSManaged public var language: String?
    @NSManaged public var repositoryId: Int32
    @NSManaged public var repositoryUrl: URL?
    @NSManaged public var score: Double
    @NSManaged public var stargazers_count: Int32
    @NSManaged public var updated_at: String?
    @NSManaged public var watchers_count: Int32
    @NSManaged public var forks_count: Int32
//    @NSManaged public var owner: GitHubUserEntity

}
