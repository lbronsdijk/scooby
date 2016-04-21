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
    var fadeIn: Bool = false
    
    init(coder: NSCoder = NSCoder.empty(), fadeIn: Bool = false) {
        super.init(coder: coder)!
        self.fadeIn = fadeIn
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationController.sharedInstance.stopLocating()
        GroupViewController.group = nil
        
        // initialize view
        dashboardView = DashboardView(frame: viewRect)
        view.addSubview(dashboardView)
        
        dashboardView.createButton.addTarget(self, action: #selector(createGroup), forControlEvents: .TouchUpInside)
        dashboardView.joinButton.addTarget(self, action: #selector(joinGroup), forControlEvents: .TouchUpInside)
        
        if fadeIn {
            dashboardView.alpha = 0
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if fadeIn {
            UIView.animateWithDuration(0.3, animations: {
                self.dashboardView.alpha = 1
            })
        }
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

