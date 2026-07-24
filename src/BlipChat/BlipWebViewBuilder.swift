//
//  BlipWebViewBuilder.swift
//  BlipSDK
//
//  Created by Curupira on 10/01/17.
//  Copyright © 2017 Curupira. All rights reserved.
//

import Foundation
import UIKit
import WebKit
internal class BlipWebViewBuilder {
    
    var webView:WKWebView
    
    init(){
        let configuration = WKWebViewConfiguration()
        configuration.allowsInlineMediaPlayback = true
        configuration.mediaTypesRequiringUserActionForPlayback = []
        self.webView = WKWebView(frame: .zero, configuration: configuration)
    }
    
    func build() -> WKWebView{
        self.webView.scrollView.bounces = false
        self.webView.scrollView.contentInsetAdjustmentBehavior = .never
        self.webView.scrollView.keyboardDismissMode = .interactive
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }
    
    func withZoomDelegate(scrollDelegate:UIScrollViewDelegate) -> BlipWebViewBuilder {
        self.webView.scrollView.delegate = scrollDelegate
        return self
    }
    
    func withNavigationDelegate(navigationDelegate:WKNavigationDelegate) -> BlipWebViewBuilder {
        self.webView.navigationDelegate = navigationDelegate
        return self
    }
    
    func withObserver(observer:NSObject) -> BlipWebViewBuilder {
        self.webView.addObserver(observer, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        return self
    }
    
    func withUIDelegate(UIDelegate: WKUIDelegate) -> BlipWebViewBuilder {
        self.webView.uiDelegate = UIDelegate
        return self
    }
    
    
    
    
}
