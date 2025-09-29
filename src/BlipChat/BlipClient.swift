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
        Opens the Blip Chat in full screen mode, pushing it to the navigation controller.
        This is the classic integration method where the chat occupies the entire screen.
        - Parameter myView: The view controller that will present the chat
        - Parameter appKey: The bot's app key
        - Parameter options: The chat configuration options
        - Throws: **BlipErrors.emptyApiKey** if appKey is empty, **BlipErrors.emptyCredentials** if authType is .Dev and userIdentity/userPassword are empty, **BlipErrors.emptyNoNavController** if the presenting view controller has no navigation controller
    */
    @objc public static func openBlipThread(myView: UIViewController, appKey: String, options: BlipOptions = BlipOptions()) throws{
        let viewController = try getBlipThreadViewController(appKey: appKey, options: options)
        
        if myView.navigationController == nil {
            print("BlipChat Error: " + BlipErrors.emptyNoNavController.errorDescription!)
            throw BlipErrors.emptyNoNavController
        }

        myView.navigationController?.pushViewController(viewController, animated: true)
    }

    /**
        Creates and returns a configured chat view controller, without presenting it in navigation.
        Allows the integrator to add the chat as a child view controller and position it wherever desired.
        - Parameter appKey: The bot's appKey
        - Parameter options: The chat configuration options
        - Returns: A UIViewController containing the chat interface
        - Throws: **BlipErrors.emptyApiKey** if appKey is empty, **BlipErrors.emptyCredentials** if authType is .Dev and userIdentity/userPassword are empty
    */
    @objc public static func getBlipThreadViewController(appKey: String, options: BlipOptions = BlipOptions()) throws -> UIViewController {
        do {
            try validateSdkConfiguration(identifier: appKey, options: options)
        } catch {
            throw error
        }

        let storyboard = UIStoryboard(name: "Storyboard", bundle: Bundle(for: self))
        let viewController = storyboard.instantiateViewController(withIdentifier: "ThreadViewController") as! ThreadViewController

        viewController.appKey = appKey
        viewController.options = options

        return viewController
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
