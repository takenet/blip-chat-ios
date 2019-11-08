//
//  BlipClient.swift
//  BlipSDK
//
//  Created by Curupira on 09/01/17.
//  Copyright © 2017 Curupira. All rights reserved.
//

import Foundation
import UIKit

/**
 SDK to easly add BLiP conversations in your iOS app
 */
@objc public class BlipClient : NSObject{
    
    /**
        Open BlipChatController with the given apiKey and options
        - Parameter myView: The controller calling the BlipChat
        - Parameter identifier: The bot's identifier
        - Parameter options: The options parameter with all the user customizations
        - Throws: **BlipErrors.emptyApiKey** if apiKey is nil, **BlipErrors.emptyCredentials** if authType is *.Dev* and *userIdentity* or *userPassowrd*  is nil.
    */
    @objc public static func openBlipThread(myView: UIViewController, appKey: String, options:BlipOptions = BlipOptions()) throws{
        // Validate Options and ApiKey
        do {
            try validateSdkConfiguration(identifier: appKey, options: options)
        } catch {
            throw error
        }
        
        //Send values to Controller
        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle(for: self))
        let viewController = storyboard.instantiateViewController(withIdentifier: "ThreadViewController") as! ThreadViewController
        viewController.appKey = appKey
        viewController.options = options
        
        if myView.navigationController == nil {
            print("BlipChat Error: " + BlipErrors.emptyNoNavController.errorDescription!)
            throw BlipErrors.emptyNoNavController
        }
        myView.navigationController?.pushViewController(viewController, animated: true)
    }
    
    internal static func validateSdkConfiguration(identifier: String, options:BlipOptions) throws {
        if identifier.isEmpty {
            throw BlipErrors.emptyApiKey
        }
        
        if options.authConfig.authType == .Dev {
            if options.authConfig.userIdentity?.isEmpty != false || options.authConfig.userPassword?.isEmpty != false {
                throw BlipErrors.emptyCredentials
            }
        }
    }
}
