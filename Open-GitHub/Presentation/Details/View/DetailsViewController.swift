//
//  DetailsViewController.swift
//  Open-GitHub
//
//  Created by Aleksander Logozinsky on 20.06.2020.
//  Copyright © 2020 Aleksander Logozinsky. All rights reserved.
//

import UIKit
import WebKit
import RxSwift

class DetailsViewController: UIViewController, WKUIDelegate {
    
    let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = .white
        activityIndicator.startAnimating()
        
        return activityIndicator
    }()
    
    let webView: WKWebView = {
        let webView = WKWebView()
        
        return webView
    }()
    
    private var viewModel: DetailsViewPresenteble!
    var viewModelBuilder: DetailsViewPresenteble.Builder!
    var coordinator: DetailsCoordinator!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewModel = viewModelBuilder(coordinator.model)
        
        bindView()
        webView.load(viewModel.output)
        
        setupLayout(for: activityIndicator, webView)
    }
    
    private func setupLayout(for views: UIView ...) {
        view.addSubviews(views)
        
        view.backgroundColor = .gitHubWhiteColor
        webView.backgroundColor = .clear
        
        webView.fillSuperview()
        activityIndicator.anchor(centerY: view.centerYAnchor, centerX: view.centerXAnchor)
    }
    
    private func bindView() {
        let loading = webView.rx.loading.share()
        
        Observable
            .zip(loading, loading.skip(1)) { $0 && !$1 }
            .filter { $0 }
            .subscribe { [weak self] _ in
                self?.webView.isHidden = false
                self?.activityIndicator.stopAnimating()
            }.disposed(by: disposeBag)
    }

}
