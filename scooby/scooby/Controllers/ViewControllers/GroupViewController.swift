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

class GroupViewController: BaseViewController, MultipeerDelegate {

    let mulitpeerController = MultipeerController.sharedInstance
    
    static var group : Group?
    var groupView : GroupView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // title
        if GroupViewController.group != nil {
            self.title = "\(GroupViewController.group!.creator.displayName)s Group"
        } else {
            self.title = "Group"
        }
        // initialize view
        groupView = GroupView(frame: viewRect)
        view.addSubview(groupView)
        // close button
        let closeButton = UIButton(frame: CGRectMake(0, 0, 44, 44))
        closeButton.setImage(IonIcons.imageWithIcon(
            ion_ios_close_empty,
            size: 44.0,
            color: UIColor(hexString: COLOR_WHITE)
            ), forState: .Normal)
        closeButton.addTarget(self, action: #selector(close), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // multipeer
        mulitpeerController.delegate = self
    }

    func close() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
