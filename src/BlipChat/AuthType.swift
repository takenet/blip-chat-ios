//
//  AuthType.swift
//  BlipSDK
//
//  Created by Curupira on 07/04/17.
//  Copyright © 2017 Curupira. All rights reserved.
//
import Foundation
/**
 Provider for AuthType
 */
@objc public class AuthConfig : NSObject {
    @objc var authType: AuthType
    @objc var userIdentity: String?
    @objc var userPassword: String?
    
    @objc public override init() {
        self.authType = .Guest
    }
    
    @objc public init(authType: AuthType) {
        self.authType = authType
    }
    
    @objc public init(authType: AuthType, userIdentity: String, userPassword: String) {
        self.authType = authType
        self.userIdentity = userIdentity
        self.userPassword = userPassword
    }
}

/**
 Types of authentication for BlipChat users
 - *Guest*: Default type, user will not be identified
 - *Dev*: App developer is responsible for giving user data
 */
@objc public enum AuthType : Int {
    /// Default type, user will not be identified
    case Guest
    /// App developer is responsible for giving user data
    case Dev
    
    func name() -> String {
        switch self {
            case .Guest:
                return "Guest"
            case .Dev:
                return "Dev"
        }
    }
}
