//
//  GroupMember.swift
//  scooby
//
//  Created by Lloyd Keijzer on 20-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import CoreLocation

class GroupMember {
    
    var peerId: MCPeerID!
    var circleView: CircleView?
    var location: CLLocationCoordinate2D?
    var degrees: Double?
    var distance: Double?
    
    init(peerId: MCPeerID) {
        self.peerId = peerId
    }
}