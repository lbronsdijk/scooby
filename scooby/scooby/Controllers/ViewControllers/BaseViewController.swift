//
//  BaseViewController.swift
//  scooby
//
//  Created by Lloyd Keijzer on 12-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var viewRect : CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // portrait only
        (UIApplication.sharedApplication().delegate as! AppDelegate).restrictRotation = true
        // set default title
        self.title = "Scooby"
        // calculate view frame
        viewRect = CGRectMake(0, 0, view.frame.width, view.frame.height - 64)
        // remove title from back button
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action: nil)
    }
}
