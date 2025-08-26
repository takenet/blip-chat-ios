//
//  Account.swift
//  BlipChat
//
//  Created by Curupira on 26/03/2018.
//  Copyright © 2018 Curupira. All rights reserved.
//

import Foundation

@objc public class Account : NSObject, Encodable {
    @objc public var fullName: String?
    @objc public var address: String?
    @objc public var city: String?
    @objc public var email: String?
    @objc public var phoneNumber: String?
    @objc public var photoUri: URL?
    @objc public var cellPhoneNumber: String?
    @objc public var gender: String?
    @objc public var culture: String?
    @objc public var extras: [String: String]?
    @objc public var password: String?
    @objc public var oldPassword: String?
    
    private var isTemporaryBool: Bool?
    @objc public var isTemporary: Bool {
        get {
            return isTemporaryBool ?? false
        }
        set(newValue) {
            isTemporaryBool = newValue
        }
    }
    
    private var allowGuestSenderBool: Bool?
    @objc public var allowGuestSender: Bool {
        get {
            return allowGuestSenderBool ?? false
        }
        set(newValue) {
            allowGuestSenderBool = newValue
        }
    }
    
    private var allowUnknownSenderBool: Bool?
    @objc public var allowUnknownSender: Bool {
        get {
            return allowUnknownSenderBool ?? false
        }
        set(newValue) {
            allowUnknownSenderBool = newValue
        }
    }
    
    private var storeMessageContentBool: Bool?
    @objc public var storeMessageContent: Bool {
        get {
            return storeMessageContentBool ?? false
        }
        set(newValue) {
            storeMessageContentBool = newValue
        }
    }
    
    private var encryptMessageContentBool: Bool?
    @objc public var encryptMessageContent: Bool {
        get {
            return encryptMessageContentBool ?? false
        }
        set(newValue) {
            encryptMessageContentBool = newValue
        }
    }
    
    
    @objc public init(fullname: String?, email: String?) {
        self.fullName = fullname
        self.email = email
    }
    
    enum CodingKeys: String, CodingKey {
        case fullName
        case address
        case city
        case email
        case phoneNumber
        case photoUri
        case cellPhoneNumber
        case gender
        case culture
        case extras
        case password
        case oldPassword
        
        case isTemporary
        case allowGuestSender
        case allowUnknownSender
        case storeMessageContent
        case encryptMessageContent
    }
    
    public func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        if fullName != nil { try container.encode(fullName, forKey: .fullName) }
        if address != nil { try container.encode(address, forKey: .address) }
        if city != nil { try container.encode(city, forKey: .city) }
        if email != nil { try container.encode(email, forKey: .email) }
        if phoneNumber != nil { try container.encode(phoneNumber, forKey: .phoneNumber) }
        if photoUri != nil { try container.encode(photoUri, forKey: .photoUri) }
        if cellPhoneNumber != nil { try container.encode(cellPhoneNumber, forKey: .cellPhoneNumber) }
        if gender != nil { try container.encode(gender, forKey: .gender) }
        if culture != nil { try container.encode(culture, forKey: .culture) }
        if extras != nil { try container.encode(extras, forKey: .extras) }
        if password != nil { try container.encode(password, forKey: .password) }
        if oldPassword != nil { try container.encode(oldPassword, forKey: .oldPassword) }
        
        if isTemporaryBool != nil { try container.encode(isTemporaryBool, forKey: .isTemporary) }
        if allowGuestSenderBool != nil { try container.encode(allowGuestSenderBool, forKey: .allowGuestSender) }
        if allowUnknownSenderBool != nil { try container.encode(allowUnknownSenderBool, forKey: .allowUnknownSender) }
        if storeMessageContentBool != nil { try container.encode(storeMessageContentBool, forKey: .storeMessageContent) }
        if encryptMessageContentBool != nil { try container.encode(encryptMessageContentBool, forKey: .encryptMessageContent) }
    }
}

