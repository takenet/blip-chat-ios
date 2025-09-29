//
//  UiNavigationControllerExtension.swift
//  BlipChat
//
//  Created by Usuario Takenet on 20/02/2018.
//  Copyright © 2018 Curupira. All rights reserved.
//

import Foundation
extension UINavigationController {
    
    override open var shouldAutorotate: Bool {
        get {
            if let visibleVC = visibleViewController {
                if #available(iOS 16.0, *) {
                    let supportedOrientations = visibleVC.supportedInterfaceOrientations
                    return supportedOrientations.rawValue.nonzeroBitCount > 1
                } else {
                    return visibleVC.shouldAutorotate
                }
            }

            if #available(iOS 16.0, *) {
                let supportedOrientations = self.supportedInterfaceOrientations
                return supportedOrientations.rawValue.nonzeroBitCount > 1
            } else {
                return super.shouldAutorotate
            }
        }
    }
    
    override open var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.preferredInterfaceOrientationForPresentation
            }
            return super.preferredInterfaceOrientationForPresentation
        }
    }
    
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask{
        get {
            if let visibleVC = visibleViewController {
                return visibleVC.supportedInterfaceOrientations
            }
            return super.supportedInterfaceOrientations
        }
    }
}
