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

class DashboardViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate, MultipeerDelegate {

    let mulitpeerController = MultipeerController.sharedInstance
    
    var dashboardView : DashboardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initialize view
        dashboardView = DashboardView(frame: viewRect)
        view.addSubview(dashboardView)
        // assigning datasource and delegate to tableview
        dashboardView.peerTable.dataSource = self
        dashboardView.peerTable.delegate = self
        // group button
        let groupButton = UIButton(frame: CGRectMake(0, 0, 44, 44))
        groupButton.setImage(IonIcons.imageWithIcon(
            ion_ios_people,
            size: 44.0,
            color: UIColor(hexString: COLOR_WHITE)
        ), forState: .Normal)
        groupButton.addTarget(self, action: #selector(goToGroup), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: groupButton)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // multipeer
        mulitpeerController.delegate = self
        // reload data
        dashboardView.peerTable.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print ("numberOfRowsInSection: \(mulitpeerController.peers.count)")
        return mulitpeerController.peers.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44.0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "peerCell")
        cell.backgroundColor = UIColor(hexString: COLOR_LIGHTGRAY)
        cell.textLabel?.text = mulitpeerController.peers[indexPath.row].displayName
        cell.textLabel?.textColor = UIColor(hexString: COLOR_WHITE)
        
        return cell
    }
    
    func peerDidConnect(peerID: MCPeerID) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {

            if let row = self.mulitpeerController.peers.indexOf(peerID) {

                let indexPath = NSIndexPath(forRow: row, inSection: 0)
                print("add row at index: \(indexPath.row)")

                dispatch_async(dispatch_get_main_queue(), {
                    self.dashboardView.peerTable.beginUpdates()
                    self.dashboardView.peerTable.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Left)
                    self.dashboardView.peerTable.endUpdates()
                })

            }
        })
    }
    
    func peerIsConnecting(peerID: MCPeerID) {
        
    }
    
    func lostConnectionToPeer(peerID: MCPeerID, index: Int) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            print("delete row at index: \(indexPath.row)")
            
            dispatch_async(dispatch_get_main_queue(), {
                self.dashboardView.peerTable.beginUpdates()
                self.dashboardView.peerTable.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                self.dashboardView.peerTable.endUpdates()
            })
        })
    }
    
    func goToGroup() {
        self.navigationController?.pushViewController(GroupPortalViewController(), animated: true)
    }
}

