//
//  GroupViewController.swift
//  scooby
//
//  Created by Lloyd Keijzer on 13-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit
import MultipeerConnectivity
import ionicons

class GroupViewController: BaseViewController, MultipeerDelegate, GroupDelegate {

    let mulitpeerController = MultipeerController.sharedInstance
    
    static var lastChangedName: String?
    
    static var group : Group?
    var groupView : GroupView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initialize view
        groupView = GroupView(frame: viewRect)
        if (GroupViewController.lastChangedName != nil) {
            groupView.changeLastJoinedName(GroupViewController.lastChangedName!)
        } else {
            groupView.changeLastJoinedName(MultipeerController.displayName!)
        }
        view.addSubview(groupView)
        // close button
        let closeButton = UIButton(frame: CGRectMake(0, 0, 44, 44))
        closeButton.setImage(IonIcons.imageWithIcon(
            ion_close_round,
            size: 24.0,
            color: UIColor(hexString: COLOR_WHITE)
            ), forState: .Normal)
        closeButton.addTarget(self, action: #selector(close), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
        // targets
        groupView.partyButton.addTarget(self, action: #selector(party), forControlEvents: .TouchUpInside)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // multipeer
        mulitpeerController.delegate = self
        GroupViewController.group?.delegate = self
    }
    
    func memberDidJoin(member: GroupMember) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            GroupViewController.lastChangedName = member.peerId.displayName
            
            dispatch_async(dispatch_get_main_queue(), {
                self.groupView.changeLastJoinedName(member.peerId.displayName)
            })
        }
    }

    func close() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func party() {
        let navigationController = NavigationController(rootViewController: RadarViewController())
        self.presentViewController(navigationController, animated: true, completion: nil)
    }
}
