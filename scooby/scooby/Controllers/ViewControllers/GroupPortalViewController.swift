//
//  GroupViewController.swift
//  scooby
//
//  Created by Lloyd Keijzer on 13-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit

class GroupPortalViewController: BaseViewController {
    
    let mulitpeerController = MultipeerController.sharedInstance
    
    var portalView : GroupPortalView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // title
        self.title = "Group"
        // initialize view
        portalView = GroupPortalView(frame: viewRect)
        view.addSubview(portalView)
        // targets
        portalView.createButton.addTarget(self, action: #selector(create), forControlEvents: .TouchUpInside)
    }
    
    func create() {
        GroupViewController.group = Group(creator: mulitpeerController.peerId)
        let navigationController = NavigationController(rootViewController: GroupViewController())
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
}
