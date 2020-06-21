//
//  WKWebView.swift
//  Open-GitHub
//
//  Created by Aleksander Logozinsky on 22.06.2020.
//  Copyright © 2020 Aleksander Logozinsky. All rights reserved.
//

import WebKit
import RxSwift

extension Reactive where Base: WKWebView {
    
    var loading: Observable<Bool> {
        return observeWeakly(Bool.self, "loading", options: [.initial, .new]) .map { $0 ?? false }
    }
    
}
