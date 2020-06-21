//
//  SearchResultCollectionViewCell.swift
//  Open-GitHub
//
//  Created by Aleksander Logozinsky on 21.06.2020.
//  Copyright © 2020 Aleksander Logozinsky. All rights reserved.
//

import UIKit

class SearchResultCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = String(describing: self)
    
    let fullnameLabel = Label()
    let descriptionLabel = Label()
    let imageView = UIImageView(cornerRadius: 8)
    let starLabel = Label()
    let languageLabel = Label()
    
    lazy var viewModel = SearchResultViewModel(delegate: self)
    
    func configureWithData(_ data: GitHubRepository) {
        if let imageUrl = data.owner.avatarUrl {
            viewModel.fetchImage(from: imageUrl)
        }
        
        if let fullName = data.fullName {
            fullnameLabel.setValue(fullName, fontWeight: .semibold, numberOfLines: 1, color: .gitHubLinkColor)
        }
        
        if let description = data.description {
            descriptionLabel.setValue(description, size: 18, numberOfLines: 2)
        }
        
        if let language = data.language {
            languageLabel.setValue(language, size: 12)
        }
        
        starLabel.setValue("☆ \(viewModel.formatCounter(value: data.stargazersCount))", size: 12)
        
        setupLayout(for: fullnameLabel, imageView, descriptionLabel, starLabel, languageLabel)
    }
    
    private func setupLayout(for views: UIView ...) {
        contentView.addSubviews(views)
        
        contentView.backgroundColor = .white
        
        imageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, padding: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 0), size: CGSize(width: 20, height: 20))
        fullnameLabel.anchor(leading: imageView.trailingAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 16))
        fullnameLabel.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        descriptionLabel.anchor(top: imageView.bottomAnchor, leading: contentView.leadingAnchor, trailing: contentView.trailingAnchor, padding: UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 16))
        starLabel.anchor(leading: descriptionLabel.leadingAnchor, bottom: contentView.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0), size: CGSize())
        languageLabel.anchor(leading: starLabel.trailingAnchor, bottom: contentView.bottomAnchor, padding: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 0), size: CGSize())
    }
    
}

extension SearchResultCollectionViewCell: SearchResultViewModelDelegate {
    func didFetchImage(image: UIImage) {
        imageView.image = image
    }
}
