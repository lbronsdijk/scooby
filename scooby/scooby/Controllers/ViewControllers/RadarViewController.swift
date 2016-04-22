//
//  RadarViewController.swift
//  scooby
//
//  Created by Lloyd Keijzer on 18-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit
import ionicons
import MapKit

class RadarViewController: BaseViewController, GroupDelegate {

    static let DEBUG_MODE = false
    
    var radarView: RadarView!
    var stopRadar: Bool = false
    
    private let navigationViewController = NavigationViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationController.sharedInstance.startLocating()
        
        // initialize view
        radarView = RadarView(frame: viewRect)
        view.addSubview(radarView)
        
        if RadarViewController.DEBUG_MODE {
            radarView.changeNearestScoobyName("Debug")
        }
        
        navigationViewController.initialize(view.frame, controller: self)
        
        showMenuButton()
        
        // update radar
        updateRadar()
    }
    
    func showMenuButton() {
        // menu button
        let menuButton = UIButton(frame: CGRectMake(0, 0, 44, 44))
        menuButton.setImage(IonIcons.imageWithIcon(
            ion_navicon_round,
            size: 32.0,
            color: UIColor(hexString: COLOR_WHITE)
            ), forState: .Normal)
        menuButton.addTarget(self, action: #selector(showMenu), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuButton)
    }
    
    func showCloseButton() {
        let closeButton = UIButton(frame: CGRectMake(0, 0, 44, 44))
        closeButton.setImage(IonIcons.imageWithIcon(
            ion_close_round,
            size: 24.0,
            color: UIColor(hexString: COLOR_WHITE)
            ), forState: .Normal)
        closeButton.addTarget(self, action: #selector(closeMenu), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeButton)
    }
    
    override func viewWillAppear(animated: Bool) {
        GroupViewController.group?.delegate = self
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        stopRadar = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        radarView.animateRadar()
    }
    
    func memberDidJoin(member: GroupMember) {
        
        if member.circleView == nil {
            radarView.circleContainer.addCircle(member)
        }
    }
    
    func showMenu() {
        
        navigationViewController.navigationView!.alpha = 0
        view.addSubview(navigationViewController.navigationView!)
        self.showCloseButton()
        
        UIView.animateWithDuration(0.3, animations: { 
            self.navigationViewController.navigationView!.alpha = 1
        })
    }
    
    func closeMenu() {
        
        navigationViewController.navigationView!.alpha = 1
        showMenuButton()
        
        UIView.animateWithDuration(0.3, animations: {
            self.navigationViewController.navigationView!.alpha = 0
        }) { (Bool) in
            self.navigationViewController.navigationView!.removeFromSuperview()
        }
    }
    
    func updateRadar() {
        
        let locationController = LocationController.sharedInstance
        
        if (locationController.location == nil || locationController.heading == nil) {
            return
        }
        
        var distance: Double?
        var nearestName: String?
        
        for member: GroupMember in (GroupViewController.group?.members)! {
            
            if (member.location == nil || member.peerId == MultipeerController.sharedInstance.peerId) {
                continue
            }
            
            if member.circleView == nil {
                self.radarView.circleContainer.addCircle(member)
            }
            
            let currentDistance = LocationController.distanceBetweenCoordinates(
                locationController.location!,
                toCoordinates: member.location!
            )
            
            member.distance = currentDistance
            
            if (distance == nil || (currentDistance < distance!)) {
                distance = currentDistance
                nearestName = member.peerId.displayName
            }
            
            let degrees = LocationController.getBearingBetweenTwoPoints(
                locationController.location!,
                point2: member.location!
            )
            
            var radarDegrees: Double = locationController.heading! + degrees
            
            while (radarDegrees > 360) {
                radarDegrees -= 360
            }
            
            while (radarDegrees < 0) {
                radarDegrees += 360
            }
            
            member.degrees = radarDegrees
            
            if radarView.circleContainer.detailView.member != nil && radarView.circleContainer.detailView.member!.circleView == member.circleView {
                radarView.circleContainer.assignMemberToDetail(member.circleView!)
            }
            
            self.radarView.circleContainer.moveCircleToDegree(
                self.radarView.circleContainer.peerCircles.last!,
                degrees: (radarDegrees)
            )
        }
        
        if nearestName != nil {
            self.radarView.changeNearestScoobyName(nearestName!)
        }
        
        if !self.stopRadar {
            self.performSelector(#selector(self.updateRadar), withObject: nil, afterDelay: 0.034)
        }
    }
}
