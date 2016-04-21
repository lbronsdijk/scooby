//
//  NavigationViewController.swift
//  scooby
//
//  Created by Lloyd Keijzer on 21-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit

class NavigationViewController: BaseViewController {

    var navigationView : NavigationView?
    var controller: BaseViewController?
    
    func initialize(frame: CGRect, controller: BaseViewController) {
        
        self.controller = controller
        
        // initialize view
        viewRect = CGRectMake(0, 0, frame.width, frame.height)
        navigationView = NavigationView(frame: viewRect)
        
        navigationView!.addButton.addTarget(self, action: #selector(addScoobies), forControlEvents: .TouchUpInside)
        navigationView!.panicButton.addTarget(self, action: #selector(panic), forControlEvents: .TouchUpInside)
    }
    
    func addScoobies() {
        let groupViewController = GroupViewController(fromRadar: true)
        let navigationController = NavigationController(rootViewController: groupViewController)
        controller!.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func panic() {
        controller!.presentViewController(NavigationController(rootViewController: PanicViewController()), animated: true, completion: nil)
    }
}
