//
//  ViewController.swift
//  BlipSdkWebView
//
//  Created by Curupira on 30/12/16.
//  Copyright © 2016 Curupira. All rights reserved.
//

import UIKit
import WebKit
import BlipChat

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func openThread(_ sender: UIButton) {
        let options: BlipOptions
        if sender.tag == 0{
            options = BlipOptions()
            print("Guest auth")
        } else {
            let authConfig = AuthConfig(authType: .Dev, userIdentity: "testeiosuser208-transbordo", userPassword: "12345678")
            let account = Account(fullname: "Teste iOS 208 Transbordo", email: "testeiosuser208-transbordo@test.com")
            account.extras =  ["versao": "transbordo"]
            account.encryptMessageContent = true
            options = BlipOptions(authType: authConfig, account: account)
            print("Dev auth")
        }
        
        #if swift(>=4)
            options.windowTitle = "Swift 4"
        #elseif swift(>=3)
            options.windowTitle = "Swift 3"
        #elseif swift(>=2)
            options.windowTitle = "Swift 2"
        #else
            options.windowTitle = "Swift 1"
        #endif
        do {
            try BlipClient.openBlipThread(myView: self, appKey: "YmxpcGNoYXR0YWtlOjA2NGFkMWIwLTg0YTEtNDA5Mi04NjFiLWRlZGIxZWY0YzQ1Zg==", options: options)
        } catch {
            print (error.localizedDescription)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

