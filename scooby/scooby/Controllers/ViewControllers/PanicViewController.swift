//
//  PanicViewController.swift
//  scooby
//
//  Created by Lloyd Keijzer on 21-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit
import ionicons

class PanicViewController: BaseViewController {

    var panicView: PanicView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // initialize view
        panicView = PanicView(frame: viewRect)
        view.addSubview(panicView)
        
        // close button
        let closeButton = UIButton(frame: CGRectMake(0, 0, 44, 44))
        closeButton.setImage(IonIcons.imageWithIcon(
            ion_close_round,
            size: 24.0,
            color: UIColor(hexString: COLOR_WHITE)
            ), forState: .Normal)
        closeButton.addTarget(self, action: #selector(close), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
        
        panicView.moonButton.addTarget(self, action: #selector(toTheMoonAndNeverReturn), forControlEvents: .TouchUpInside)
    }
    
    func close() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func toTheMoonAndNeverReturn() {
        
        for member: GroupMember in (GroupViewController.group?.members)! {
            
            if (member.peerId != MultipeerController.sharedInstance.peerId) {
                Datacalls.sendData(
                    "leave",
                    data: NSDictionary(),
                    receiver: member.peerId,
                    successHandler: {},
                    errorHandler: { (error) in }
                )
            }
        }
        
        self.navigationItem.rightBarButtonItem = nil
        
        UIView.animateWithDuration(1.0) { 
            self.panicView.fadeView.alpha = 0
            self.panicView.backgroundColor = UIColor(hexString: COLOR_GREEN)
        }
        UIView.animateWithDuration(1.3, animations: {
            self.panicView.rocket.frame = CGRectMake(
                self.panicView.frame.width,
                0 - self.panicView.rocket.frame.height,
                self.panicView.rocket.frame.width,
                self.panicView.rocket.frame.height
            )
        }) { (Bool) in
            LocationController.sharedInstance.stopLocating()
            GroupViewController.group = nil
            (UIApplication.sharedApplication().delegate as! AppDelegate).window!.rootViewController = NavigationController(rootViewController: DashboardViewController(fadeIn: true))
        }
    }
}
