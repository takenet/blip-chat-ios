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
        let webViewConfiguration = WKWebViewConfiguration()
        
        // Configure preferences for keyboard support
        let preferences = WKWebpagePreferences()
        if #available(iOS 14.5, *) {
            preferences.allowsContentJavaScript = true
        }
        webViewConfiguration.defaultWebpagePreferences = preferences
        
        // Configure user content controller
        webViewConfiguration.userContentController = WKUserContentController()
        
        // Allow inline media playback
        webViewConfiguration.allowsInlineMediaPlayback = true
        
        // Allow audio and video playback without user interaction
        if #available(iOS 10.0, *) {
            webViewConfiguration.mediaTypesRequiringUserActionForPlayback = []
        }
        
        self.webView = WKWebView(frame: .zero, configuration: webViewConfiguration)
    }
    
    func build() -> WKWebView{
        self.webView.scrollView.bounces = false
        self.webView.translatesAutoresizingMaskIntoConstraints = false
        
        // Enable keyboard support
        self.webView.scrollView.keyboardDismissMode = .interactive
        
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
