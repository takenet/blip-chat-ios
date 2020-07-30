//
//  ThreadViewController.swift
//  BlipSDK
//
//  Created by Curupira on 10/01/17.
//  Copyright © 2017 Curupira. All rights reserved.
//

import UIKit
import WebKit
internal class ThreadViewController: UIViewController, WKNavigationDelegate, UIScrollViewDelegate, WKUIDelegate {
    
    var appKey : String!
    var options : BlipOptions!
    var webView:WKWebView!
    var baseUrl : URL!
    var html : String = ""

    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var baseView: UIView!
    
    override func viewDidAppear(_ animated: Bool) {
        webView.frame = baseView.frame
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        
        self.webView = BlipWebViewBuilder()
                .withNavigationDelegate(navigationDelegate: self)
                .withZoomDelegate(scrollDelegate: self)
                .withObserver(observer: self)
                .withUIDelegate(UIDelegate: self)
                .build()
        view.addSubview(webView)
        
        setProgressView();
        
        // Add listeners for keyboard
        NotificationCenter.default.addObserver(self, selector: #selector(ThreadViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(ThreadViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(ThreadViewController.keyboardDidHide), name: UIResponder.keyboardDidHideNotification, object: self.view.window)

        var resourcesBundle = Bundle(identifier: "org.cocoapods.BlipChat");
        
        if (resourcesBundle?.load()) != nil {
           print("Bundle using indentifier")
        } else {
           resourcesBundle = Bundle(for: type(of: self));
        }
        
        // Create cancel button
        let leftArrow = UIImage(named:"leftArrow", in: resourcesBundle, compatibleWith: nil);
        var cancelButton: UIBarButtonItem? = nil;

        if (leftArrow != nil) {
            cancelButton = UIBarButtonItem(image: leftArrow, style: .plain, target: self, action: #selector(ThreadViewController.handleCancel))
        } else {
            cancelButton = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(ThreadViewController.handleCancel))
        }
        
        self.navigationController?.topViewController?.navigationItem.leftBarButtonItem = cancelButton
        self.navigationController?.topViewController?.navigationItem.title = self.options.windowTitle
        
        // Build html with user data
        let htmlFile = resourcesBundle!.path(forResource: "BlipSdkTemplate", ofType: "html")!;
        html = try! String(contentsOfFile: htmlFile, encoding: String.Encoding.utf8)
            .replacingOccurrences(of: Constants.API_KEY_VAR_KEY, with: self.appKey)
            .replacingOccurrences(of: Constants.AUTHCONFIG_VAR_KEY, with: self.options.getAuthTypeConfig())
            .replacingOccurrences(of: Constants.ACCOUNT_VAR_KEY, with: self.options.getAccount())
            .replacingOccurrences(of: Constants.CONNECTION_DATA_KEY, with: self.options.getConnectionDataConfig())
            .replacingOccurrences(of: Constants.SCRIPT_SDK_URL_KEY, with: self.options.customWidgetUrl ?? Constants.BLIP_SDK_URL)
            .replacingOccurrences(of: Constants.IFRAME_URL_KEY, with: self.options.customCommonUrl ?? Constants.IFRAME_URL)
            .replacingOccurrences(of: Constants.CUSTOM_COMMON_URL_KEY, with: self.options.customCommonUrl ?? "");
        
        self.webView.load(URLRequest(url:URL(string:Constants.BLIP_BLANK_PAGE)!))
        baseUrl = URL(string: "https://\(Bundle.main.bundleIdentifier!.lowercased())/")
        
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = baseView.frame
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        webView?.removeObserver(self, forKeyPath: "estimatedProgress")
    }
    
    /// Handle keyboard appearing on screen
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let statusBarHeight =  UIApplication.shared.statusBarFrame.height
            let navBarheight = self.navigationController?.navigationBar.bounds.size.height
            let height = -keyboardSize.height + statusBarHeight + navBarheight!
            self.view.frame.origin.y = height
            
            // Notify about blipchat that keyboard is open
            self.webView.evaluateJavaScript("setKeyboardOpen(true)", completionHandler: nil)
        }
        
    }
    
    /// Handle keyboard hiding on screen
    @objc func keyboardWillHide(notification: NSNotification) {
        let statusBarHeight =  UIApplication.shared.statusBarFrame.height
        if let navBarheight = self.navigationController?.navigationBar.bounds.size.height {
            self.view.frame.origin.y = statusBarHeight + navBarheight
        }
        
        // Notify about blipchat that keyboard is closed
        self.webView.evaluateJavaScript("setKeyboardOpen(false)", completionHandler: nil)
    }
    
    /// Handle keyboard after hidden of screen
    @objc func keyboardDidHide(notification: NSNotification) {
        // Prevent animation overlay
        view.layer.removeAllAnimations()
    }
    
    /// Handle cancel button on nav bar
    @objc func handleCancel() {
        if self.webView.url != baseUrl {
            self.webView.load(URLRequest(url:URL(string:Constants.BLIP_BLANK_PAGE)!))
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    ///Delegate to create new webview request (window.open)
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration,
                      for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil { // Verify for link
            webView.load(navigationAction.request)
        } else if navigationAction.request.url?.absoluteString == Constants.BLIP_BLANK_PAGE { // Verify for blank page
            webView.loadHTMLString(html, baseURL: baseUrl)
        }
        return nil
    }
    
    /// Delegate to loading content on WebView
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.targetFrame == nil { // Verify for link
            webView.load(navigationAction.request)
        } else if navigationAction.request.url?.absoluteString == Constants.BLIP_BLANK_PAGE { // Verify for blank page
            webView.loadHTMLString(html, baseURL: baseUrl)
        }
        decisionHandler(.allow)
    }
    
    /// Delegate to prevent scroll on chat webview
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if webView.url == baseUrl {
            scrollView.contentOffset.y = 0
        }
    }
    
    /// Observer to update progressView
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
            if webView.estimatedProgress == 1.0 {
                progressView.isHidden = true
            } else {
                progressView.isHidden = false
            }
        }
    }
    
    /// Create the progressView to show WkWebView load progress
    func setProgressView() {
        progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressView)
        
        view.addConstraint(NSLayoutConstraint(item: progressView, attribute: .top, relatedBy: .equal, toItem: self.topLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: progressView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0.0))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: progressView, attribute: .trailing, multiplier: 1.0, constant: 0.0))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("BLiP Chat - Finish loading HTML string successfully")
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print("BLiP Chat - Fail navigation: \(error)")
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print("BLiP Chat - Fail provisional navigation: \(error)")
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}
