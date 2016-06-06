//
//  UIViewControllerExtensions.swift
//  Little-Library
//
//  Created by GLR on 6/5/16.
//  Copyright © 2016 GLR. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentOKAlert(title: String, message: String) {
        presentAlert(title, message: message)
    }
    
    func presentSingleButtonAlert(title: String, message: String, buttonTitle: String, buttonClosure: (() -> Void)? = nil) {
        presentAlert(title, message: message, defaultButtonTitle: buttonTitle, defaultClosure: buttonClosure)
    }
    
    func presentAlert(title: String,
                      message: String? = nil,
                      withCancelButton: Bool = false,
                      defaultButtonTitle: String = "OK",
                      cancelButtonTitle: String = "Cancel",
                      cancelClosure: (() -> Void)? = nil,
                      defaultClosure: (() -> Void)? = nil) {
        let controller = UIAlertController.createAlert(title, message: message, withCancelButton: withCancelButton, defaultButtonTitle: defaultButtonTitle, cancelButtonTitle: cancelButtonTitle, cancelClosure: cancelClosure, defaultClosure: defaultClosure)
        presentViewController(controller, animated: true, completion: nil)
    }


}
    

