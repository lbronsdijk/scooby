//
//  ViewController.swift
//  scooby
//
//  Created by Lloyd Keijzer on 11-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit
import MultipeerConnectivity
import ionicons

class DashboardViewController: BaseViewController {

    var dashboardView : DashboardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initialize view
        dashboardView = DashboardView(frame: viewRect)
        view.addSubview(dashboardView)
        
        dashboardView.createButton.addTarget(self, action: #selector(createGroup), forControlEvents: .TouchUpInside)
        dashboardView.joinButton.addTarget(self, action: #selector(joinGroup), forControlEvents: .TouchUpInside)
    }
    
    func createGroup() {
        GroupViewController.group = Group(creator: MultipeerController.sharedInstance.peerId)
        let navigationController = NavigationController(rootViewController: GroupViewController())
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func joinGroup() {
        let navigationController = NavigationController(rootViewController: JoinGroupViewController())
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
}

