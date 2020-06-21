//
//  SearchResultViewModel.swift
//  Open-GitHub
//
//  Created by Aleksander Logozinsky on 21.06.2020.
//  Copyright © 2020 Aleksander Logozinsky. All rights reserved.
//

import UIKit

protocol SearchResultViewModelDelegate: class {
    func didFetchImage(image: UIImage)
}

protocol CounterFormatter {
    func formatCounter(value: Int) -> String
}

extension CounterFormatter {
    func formatCounter(value: Int) -> String {
        let result: String = {
            switch value {
                case 0..<1000: return String(value)
                case 1000..<1000000:
                    let roundedValue = Double(value) / 1000
                    return String(format: "%.1f", roundedValue) + "k"
                default:
                    let roundedValue = Double(value) / 1000000
                    return String(format: "%.1f", roundedValue) + "kk"
            }
        }()
        
        return result
    }
}

struct SearchResultViewModel: CounterFormatter {
    
    weak var delegate: SearchResultViewModelDelegate?
    
    func fetchImage(from url: URL) {
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            DispatchQueue.main.async {
                if let data = data {
                    if let image = UIImage(data: data) {
                        self.delegate?.didFetchImage(image: image)
                    }
                }
            }
        }).resume()
        
    }
    
}
