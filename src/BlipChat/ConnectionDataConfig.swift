//
//  ConnectionDataConfig.swift
//  BlipChat
//
//  Created by Curupira on 12/02/19.
//  Copyright © 2019 Curupira. All rights reserved.
//

import Foundation


/**
Connection data configuration for customization
*/
@objc public class ConnectionDataConfig : NSObject, Encodable {
    
    @objc public var domain: String?
    @objc public var hostName: String?
    @objc public var port: String?
    
    @objc public init(domain: String, hostName: String, port: String) {
        self.domain = domain
        self.hostName = hostName
        self.port = port
    }
    
    enum CodingKeys: String, CodingKey {
        case domain
        case hostName
        case port
    }
    
    public func encode(to encoder: Encoder) throws
    {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        if domain != nil { try container.encode(domain, forKey: .domain) }
        if hostName != nil { try container.encode(hostName, forKey: .hostName) }
        if port != nil { try container.encode(port, forKey: .port) }
    }
    
}
