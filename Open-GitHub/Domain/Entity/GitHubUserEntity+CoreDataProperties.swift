//
//  GitHubUserEntity+CoreDataProperties.swift
//  Open-GitHub
//
//  Created by Aleksander Logozinsky on 23.06.2020.
//  Copyright © 2020 Aleksander Logozinsky. All rights reserved.
//
//

import Foundation
import CoreData


extension GitHubUserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GitHubUserEntity> {
        return NSFetchRequest<GitHubUserEntity>(entityName: "GitHubUserEntity")
    }

    @NSManaged public var userId: Int32
    @NSManaged public var avatarUrl: URL?
    @NSManaged public var login: String?
    @NSManaged public var type: String?
    @NSManaged public var userUrl: URL?

}
