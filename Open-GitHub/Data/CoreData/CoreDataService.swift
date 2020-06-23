//
//  CoreDataService.swift
//  Open-GitHub
//
//  Created by Aleksander Logozinsky on 23.06.2020.
//  Copyright © 2020 Aleksander Logozinsky. All rights reserved.
//

import CoreData
import UIKit

class CoreDataService {
    
    static let shared = CoreDataService()
    
    private init() {}
    
    private let context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "OpenGitHub")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container.viewContext
    }()
    
}

extension CoreDataService {
    func delete(entityName: String, completion: @escaping () -> Void) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let items = try context.fetch(fetchRequest) as! [NSManagedObject]
            
            for item in items {
                context.delete(item)
            }
            
            try context.save()
            completion()
        } catch {
            // Error Handling
            print("!!! CoreDataService: cannot deleteData")
        }
    }
    
    func fetch(completion: @escaping ([GitHubRepository]) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "GitHubRepositoryEntity")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try self.context.fetch(request)
            
            if let data = result as? [GitHubRepositoryEntity] {
                let models = data.map { (entity) -> GitHubRepository in
                    let model: GitHubRepository = .init(from: entity)
                    return model
                }
                
                completion(models)
            } else {
                fatalError()
            }
        } catch {
            print("!!! CoreDataService: cannot fetch GitHubRepositories from GitHubRepositoryEntity")
        }
    }
    
    func save(_ repositories: [GitHubRepository]) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "GitHubRepositoryEntity", in: self.context) else {
            print("!!! CoreDataService: cannot get entityDescription for GitHubRepositoryEntity")
            return
        }
        
        for item in repositories {
            // GitHubRepositoryEntity: attributes
            let gitHubRepositoryEntityObject = NSManagedObject(entity: entityDescription, insertInto: self.context) as! GitHubRepositoryEntity
            
            gitHubRepositoryEntityObject.setValue(item.id, forKeyPath: "repositoryId")
            gitHubRepositoryEntityObject.setValue(item.fullName, forKeyPath: "full_name")
            gitHubRepositoryEntityObject.setValue(item.url, forKeyPath: "html_url")
            gitHubRepositoryEntityObject.setValue(item.createdAt, forKeyPath: "created_at")
            gitHubRepositoryEntityObject.setValue(item.updatedAt, forKeyPath: "updated_at")
            gitHubRepositoryEntityObject.setValue(item.stargazersCount, forKeyPath: "stargazers_count")
            gitHubRepositoryEntityObject.setValue(item.watchersCount, forKeyPath: "watchers_count")
            gitHubRepositoryEntityObject.setValue(item.forksCount, forKeyPath: "forks_count")
            gitHubRepositoryEntityObject.setValue(item.language, forKeyPath: "language")
            gitHubRepositoryEntityObject.setValue(item.score, forKeyPath: "score")
            
            do {
                try gitHubRepositoryEntityObject.validateForInsert()
                try gitHubRepositoryEntityObject.validateForUpdate()
            } catch(let error) {
                debugPrint(error)
            }
        }
        
        do {
            try self.context.save()
        } catch(let error) {
            print("!!! CoreDataService: cannot save GitHubRepositories from GitHubRepositoryEntity")
            debugPrint(error)
        }
    }
}

