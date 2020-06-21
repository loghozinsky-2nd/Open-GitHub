//
//  DetailsViewModel.swift
//  Open-GitHub
//
//  Created by Aleksander Logozinsky on 22.06.2020.
//  Copyright © 2020 Aleksander Logozinsky. All rights reserved.
//

import Foundation

protocol DetailsViewPresenteble {
    typealias Builder = (Input) -> DetailsViewPresenteble
    typealias Input = GitHubRepository
    typealias Output = URLRequest
    
    var input: Input { get }
    var output: Output { get }
}


class DetailsViewModel: DetailsViewPresenteble {
    var input: Input
    var output: Output
    
    init(input: Input) {
        self.input = input
        self.output = Output(
            url: input.url
        )
    }
}
