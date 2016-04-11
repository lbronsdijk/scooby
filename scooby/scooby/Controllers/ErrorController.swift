//
//  ErrorController.swift
//  scooby
//
//  Created by Lloyd Keijzer on 11-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//


import UIKit

enum CustomErrorType: ErrorType {
    case NetworkError(message: String)
}

class ErrorController {
    
    static let sharedInstance = ErrorController()
    
    private var alertIsShowing: Bool = false
    
    func networkErrorHandler(message: String) {
        print("NetWorkError: \(message)")
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        if let navigationController = appDelegate.window?.rootViewController as? NavigationController {
            
            let alertController = UIAlertController(title: "Network error", message: "Some features of this application won't work without an internet connection", preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction) -> Void in
                self.alertIsShowing = false
            })
            
            alertController.addAction(okAction)
            
            if !self.alertIsShowing {
                navigationController.presentViewController(alertController, animated: true, completion: { () -> Void in
                    self.alertIsShowing = true
                })
            }
        }
    }
}
