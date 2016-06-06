//
//  UIAlertControllerExtensions.swift
//  Little-Library
//
//  Created by GLR on 6/5/16.
//  Copyright © 2016 GLR. All rights reserved.
//

import UIKit

extension UIAlertController {
    static func createAlert(title: String,
                            message: String? = nil,
                            withCancelButton: Bool = false,
                            defaultButtonTitle: String = String("OK"),
                            cancelButtonTitle: String = String("Cancel"),
                            cancelClosure: (() -> Void)? = nil,
                            defaultClosure: (() -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let defaultAction = UIAlertAction(title: defaultButtonTitle, style: .Default) { _ in
            defaultClosure?()
        }
        alertController.addAction(defaultAction)

        if withCancelButton {
            let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .Cancel) { _ in
                cancelClosure?()
            }
            alertController.addAction(cancelAction)
        }
        return alertController
    }
    
    static func createSingleButtonAlert(title: String, message: String, buttonTitle: String, buttonClosure: (() -> Void)? = nil) -> UIAlertController {
        return createAlert(title, message: message, defaultButtonTitle: buttonTitle, defaultClosure: buttonClosure)
    }


    
}
