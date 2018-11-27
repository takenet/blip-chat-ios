//
//  StringBase64Extension.swift
//  BlipSDK
//
//  Created by Curupira on 10/01/17.
//  Copyright © 2017 Curupira. All rights reserved.
//

import Foundation
extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString().addingPercentEncoding(withAllowedCharacters: .alphanumerics)!
        }
        return ""
    }
    
    func obfuscate() -> String {
        return self.toBase64()
    }
    
}
