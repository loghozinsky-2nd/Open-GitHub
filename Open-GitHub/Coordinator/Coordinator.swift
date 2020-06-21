//
//  AppCoordinator.swift
//  Open-GitHub
//
//  Created by Aleksander Logozinsky on 19.06.2020.
//  Copyright © 2020 Aleksander Logozinsky. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var childs: [Coordinator] { get set }
    
    func start()
}

extension Coordinator {
    func add(coordinator: Coordinator) {
        childs.append(coordinator)
    }
    
    func remove(coordinator: Coordinator) {
        childs = childs.filter({ $0 !== coordinator })
    }
}

class BaseCoordinator: Coordinator {
    
    var childs = [Coordinator]()
    
    func start() {
        fatalError("Base Coordinator should be call from Child Coordinator")
    }
    
}
