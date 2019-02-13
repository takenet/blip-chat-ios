//
//  Options.swift
//  BlipSDK
//
//  Created by Curupira on 07/04/17.
//  Copyright © 2017 Curupira. All rights reserved.
//

import Foundation

/**
 Options object to customize the BlipChat
 */
@objc public class BlipOptions : NSObject {
    
    /**
     AuthType for BlipChat
     */
    @objc public var authConfig: AuthConfig
    
    /**
     Account data for user
     */
    @objc public var account: Account?
    
    /**
     Custom connection data configuration
    */
    @objc public var connectionDataConfig: ConnectionDataConfig?
    
    /**
    Custom url to be used on blip chat common
    */
    @objc public var customCommonUrl: String?
    
    /**
    Custom url to fetch blip chat widget lib
    */
    @objc public var customWidgetUrl: String?
    
    /**
     Title for BlipChat controller
     */
    @objc public var windowTitle: String
    
    /**
     Use AuthType as Guest and WindowTitle as *'Blip Chat'* by default
     */
    @objc public override init() {
        self.authConfig = AuthConfig()
        windowTitle = "Blip Chat"
    }
    
    /**
     - Parameter authType: AuthTypeConfig object to define the auth mode for BlipChat
     */
    @objc public init(authType: AuthConfig) {
        self.authConfig = authType
        windowTitle = "Blip Chat"
        
    }
    
    /**
     - Parameter authType: AuthTypeConfig object to define the auth mode for BlipChat
     - Parameter account: Account object to define user properties
     */
    @objc public init(authType: AuthConfig, account: Account?) {
        self.authConfig = authType
        self.account = account
        self.windowTitle = "Blip Chat"
    }
    
    /**
     - Parameter authType: AuthTypeConfig object to define the auth mode for BlipChat
     - Parameter account: Account object to define user properties
     - Parameter windowTitle: Title for BlipChat controller
     */
    @objc public init(authType: AuthConfig, account: Account?, windowTitle: String?) {
        self.authConfig = authType
        self.account = account
        self.windowTitle = windowTitle ?? "Blip Chat"
    }
    
    /**
     - Parameter authType: AuthTypeConfig object to define the auth mode for BlipChat
     - Parameter account: Account object to define user properties
     - Parameter connectionDataConfig: Custom connection data configuration
     - Parameter customCommonUrl: Custom url to be used on BLiPChat
     - Parameter customWidgetUrl: Custom url to fetch BLiPChat widget lib
     - Parameter windowTitle: Title for BlipChat controller
     */
    @objc public init(
        authType: AuthConfig,
        account: Account?,
        connectionDataConfig: ConnectionDataConfig?,
        customCommonUrl: String?,
        customWidgetUrl: String?,
        windowTitle: String?)
    {
        self.authConfig = authType
        self.account = account
        self.connectionDataConfig = connectionDataConfig
        self.customCommonUrl = customCommonUrl
        self.customWidgetUrl = customWidgetUrl
        self.windowTitle = windowTitle ?? "Blip Chat"
    }
    
    internal func getAuthTypeConfig() -> String {
        var json = "{ \"authType\": \"\(self.authConfig.authType.name())\""
        if self.authConfig.authType == .Dev {
            json += ", \"userIdentity\": \"\(self.authConfig.userIdentity!)\", \"userPassword\": \"\(self.authConfig.userPassword!)\""
        }
        json += " }"
        return json
    }
    
    internal func getAccount() -> String {
        var accountJson: String?
        if account != nil {
            accountJson = try! String(data: JSONEncoder().encode(account), encoding: .utf8)
        }
        return accountJson ?? "{}"
    }
    
    internal func getConnectionDataConfig() -> String {
        var connectionDataJson: String?
        if connectionDataConfig != nil {
            connectionDataJson = try! String(data: JSONEncoder().encode(connectionDataConfig), encoding: .utf8)
        }
        return connectionDataJson ?? "{}"
    }
}
