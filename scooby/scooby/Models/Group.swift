//
//  Group.swift
//  scooby
//
//  Created by Lloyd Keijzer on 13-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import QRCode

class Group {
    
    var creator : MCPeerID!
    var peers : [MCPeerID]!
    var groupId : String!
    var qrCode : UIImage!
    
    init(creator : MCPeerID) {
        self.creator = creator
        self.peers = [MCPeerID]()
        self.peers.append(creator)
        self.groupId = Group.generateGroupId()
        self.qrCode = Group.generateQRForGroupId(self.groupId, creatorName: self.creator.displayName)
        print("\(creator.displayName) created a group with id: \(groupId)")
    }
    
    func join(peer : MCPeerID) {
        if !self.peers.contains(peer) {
            self.peers.append(peer)
            print("\(peer.displayName) joined your group")
        }
    }
    
    static func generateGroupId() -> String {
        return String.random(11)
    }
    
    static func generateQRForGroupId(groupId: String, creatorName: String) -> UIImage? {
        let url = NSURL(string: "Scooby://?groupId=\(groupId)&creator=\(creatorName)")
        let qrCode = QRCode(url!)
        print("Generated qrCode with url: \(url)")
        return qrCode?.image
    }
}