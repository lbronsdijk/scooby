//
//  NavigationController.swift
//  scooby
//
//  Created by Lloyd Keijzer on 11-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // show status bar y/n
        UIApplication.sharedApplication().statusBarHidden = false
        // status bar style
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        // default text color
        UINavigationBar.appearance().tintColor = UIColor(hexString: COLOR_WHITE)
        // bar color
        UINavigationBar.appearance().barTintColor = UIColor(hexString: COLOR_RED)
        // is bar transparant
        UINavigationBar.appearance().translucent = false
        // bar title attributes
        UINavigationBar.appearance().titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor(hexString: COLOR_WHITE)!,
            NSFontAttributeName: UIFont(name: FONT_OPENSANSSEMIBOLD, size: 17)!
        ]
    }
}