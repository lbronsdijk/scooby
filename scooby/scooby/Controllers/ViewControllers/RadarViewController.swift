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

class RadarViewController: BaseViewController, GroupDelegate, CLLocationManagerDelegate {

    static let DEBUG_MODE = true
    
    var radarView: RadarView!
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initialize view
        radarView = RadarView(frame: viewRect)
        view.addSubview(radarView)
        
        if RadarViewController.DEBUG_MODE {
            radarView.changeNearestScoobyName("Debug")
        }
        
        // menu button
        let menuButton = UIButton(frame: CGRectMake(0, 0, 44, 44))
        menuButton.setImage(IonIcons.imageWithIcon(
            ion_navicon_round,
            size: 32.0,
            color: UIColor(hexString: COLOR_WHITE)
            ), forState: .Normal)
        menuButton.addTarget(self, action: #selector(toggleMenu), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuButton)

        //location manager
        locationManager = CLLocationManager()
        locationManager.delegate = self
        
        locationManager.startUpdatingHeading()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        print("heading: \(newHeading.magneticHeading)")
        
        let degrees = RadarViewController.getBearingBetweenTwoPoints(
            CLLocationCoordinate2DMake(52.0395369,4.635203), // (YOUR LOCATION) zuidplaslaan 78
            point2: CLLocationCoordinate2DMake(52.044888,4.6480753) // (FRIEND LOCATION) centraal station
        )
        
        var radarDegrees: Double = newHeading.magneticHeading + degrees
        
        while (radarDegrees > 360) {
            radarDegrees -= 360
        }
        
        while (radarDegrees < 0) {
            radarDegrees += 360
        }
        
        print("radarDegrees: \(radarDegrees)")
        
        radarView.circleContainer.moveCircleToDegree(
            radarView.circleContainer.peerCircles.last!,
            degrees: (radarDegrees)
        )
    }
    
    override func viewWillAppear(animated: Bool) {
        GroupViewController.group?.delegate = self
    }
    
    func memberDidJoin(member: GroupMember) {
        radarView.circleContainer.addCircle(member)
    }
    
    func toggleMenu() {
    
    }
    
    static func degreesToRadians(degrees: Double) -> Double { return degrees * M_PI / 180.0 }
    static func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / M_PI }
    
    static func getBearingBetweenTwoPoints(point1 : CLLocationCoordinate2D, point2 : CLLocationCoordinate2D) -> Double {
        
        let lat1 = degreesToRadians(point1.latitude)
        let lon1 = degreesToRadians(point1.longitude)
        
        let lat2 = degreesToRadians(point2.latitude);
        let lon2 = degreesToRadians(point2.longitude);
        
        let dLon = lon2 - lon1;
        
        let y = sin(dLon) * cos(lat2);
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
        let radiansBearing = atan2(y, x);
        
        return radiansToDegrees(radiansBearing)
    }
}
