//
//  JoinGroupViewController.swift
//  scooby
//
//  Created by Lloyd Keijzer on 18-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit
import ionicons
import SwiftQRCode

class JoinGroupViewController: BaseViewController, MultipeerDelegate {

    let mulitpeerController = MultipeerController.sharedInstance
    
    var joinView : JoinGroupView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initialize view
        joinView = JoinGroupView(frame: viewRect)
        view.addSubview(joinView)
        // close button
        let closeButton = UIButton(frame: CGRectMake(0, 0, 44, 44))
        closeButton.setImage(IonIcons.imageWithIcon(
            ion_close_round,
            size: 24.0,
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
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // start scan
        joinView.scanner.startScan()
    }
    
    func close() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
