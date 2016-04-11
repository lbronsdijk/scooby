//
//  ViewController.swift
//  scooby
//
//  Created by Lloyd Keijzer on 11-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        (UIApplication.sharedApplication().delegate as! AppDelegate).restrictRotation = true
        self.title = "Scooby"
        self.view.backgroundColor = UIColor(hexString: COLOR_WHITE)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

