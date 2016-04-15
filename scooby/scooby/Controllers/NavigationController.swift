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
        // is bar transparant
        UINavigationBar.appearance().translucent = true
        // default text color
        UINavigationBar.appearance().tintColor = UIColor(hexString: COLOR_WHITE)
        // bar color
        UINavigationBar.appearance().barTintColor = UIColor.clearColor()
        // bar background
        UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: .Default)
        // bar shadow
        UINavigationBar.appearance().shadowImage = UIImage()
        // bar title attributes
        UINavigationBar.appearance().titleTextAttributes = [
            NSForegroundColorAttributeName: UIColor(hexString: COLOR_WHITE)!,
            NSFontAttributeName: UIFont(name: FONT_AVENIRMEDIUM, size: 20)!
        ]
    }
}