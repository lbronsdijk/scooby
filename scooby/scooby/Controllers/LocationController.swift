//
//  LocationController.swift
//  scooby
//
//  Created by Lloyd Keijzer on 21-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import Foundation
import CoreLocation

class LocationController: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance = LocationController()
    
    var locationManager: CLLocationManager!
    var heading: Double?
    var location: CLLocationCoordinate2D?
    
    private var locating: Bool = false
    
    // initialize location controller
    private override init() {
        super.init()
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
    }
    
    // start locating
    func startLocating(){
        
        if locating {
            return
        }
        
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
        locating = true
    }
    
    // stop locating
    func stopLocating() {
        
        if !locating {
            return
        }
        
        locationManager.stopUpdatingLocation()
        locationManager.stopUpdatingHeading()
        
        locating = false
    }
    
    // update location
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        location = newLocation.coordinate
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
        
            for member: GroupMember in (GroupViewController.group?.members)! {
            
                if member.peerId != MultipeerController.sharedInstance.peerId {
                    Datacalls.sendData(
                        "updateLocation",
                        data: [
                            "lat" : "\(newLocation.coordinate.latitude)",
                            "lon" : "\(newLocation.coordinate.longitude)"
                        ],
                        receiver: member.peerId,
                        reliable: false,
                        successHandler: {},
                        errorHandler: { (error) in }
                    )
                } else {
                    member.location = newLocation.coordinate
                }
            }
        }
    }
    
    // update heading
    func locationManager(manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        heading = newHeading.magneticHeading
    }
    
    // converters
    static func degreesToRadians(degrees: Double) -> Double { return degrees * M_PI / 180.0 }
    static func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / M_PI }
    
    // bearing
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
    
    // distance
    static func distanceBetweenCoordinates(
        fromCoordinates: CLLocationCoordinate2D,
        toCoordinates: CLLocationCoordinate2D) -> Double {
        
        return Double(CLLocation(
            coordinate: fromCoordinates,
            altitude:1,
            horizontalAccuracy:1,
            verticalAccuracy:-1,
            timestamp:NSDate()
        ).distanceFromLocation(CLLocation(
            coordinate: toCoordinates,
            altitude:1,
            horizontalAccuracy:1,
            verticalAccuracy:-1,
            timestamp:NSDate()
        )))
    }
}