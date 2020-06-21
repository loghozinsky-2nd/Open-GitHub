//
//  APIService+EndPoint.swift
//  Open-GitHub
//
//  Created by Aleksander Logozinsky on 20.06.2020.
//  Copyright © 2020 Aleksander Logozinsky. All rights reserved.
//

import Foundation

enum API: String {
    case main = "https://api.github.com/"
}
    
enum EndPoint: String {
    // GET method
    case searchRepository = "search/repositories"
}

