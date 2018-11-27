//
//  IllegalArgument.swift
//  BlipSDK
//
//  Created by Curupira on 10/01/17.
//  Copyright © 2017 Curupira. All rights reserved.
//

import Foundation
enum BlipErrors: LocalizedError{
    case emptyApiKey
    case emptyCredentials
    case emptyNoNavController

    var errorDescription: String?{
        switch self {
            case .emptyApiKey:
                return "ApiKey can't be empty"
            case .emptyCredentials:
                return "UserIdentifier and UserPassword must be defined for Dev authentication"
            case .emptyNoNavController:
                return "No Navigation Controller found"
            
        }
    }
}
