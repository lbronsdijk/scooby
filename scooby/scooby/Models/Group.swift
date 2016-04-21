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

protocol GroupDelegate {
    func memberDidJoin(member: GroupMember)
}

class Group {
    
    var creator : GroupMember!
    var members : [GroupMember]!
    var groupId : String!
    var qrCode : UIImage!
    var delegate: GroupDelegate?
    
    init(creator : MCPeerID) {
        self.creator = GroupMember(peerId: creator)
        self.members = [GroupMember]()
        self.members.append(self.creator)
        self.groupId = Group.generateGroupId()
        self.qrCode = Group.generateQRForGroupId(self.groupId, creatorName: self.creator.peerId.displayName)
        print("\(creator.displayName) created a group with id: \(groupId)")
    }
    
    func join(peer : MCPeerID) {
        let member = GroupMember(peerId: peer)
        self.members.append(member)
        print("\(peer.displayName) joined your group")
        if delegate != nil {
            delegate!.memberDidJoin(member)
        }
    }
    
    static func generateGroupId() -> String {
        return String.random(11)
    }
    
    static func generateQRForGroupId(groupId: String, creatorName: String) -> UIImage? {
        let url = NSURL(string: "Scooby://?groupId=\(groupId)&creator=\(creatorName)")
        var qrCode = QRCode(url!)
        print("Generated qrCode with url: \(url)")
        qrCode?.color = CIColor(rgba: "ffffffff")
        qrCode?.backgroundColor = CIColor(rgba: "d84c3aff")
        return qrCode?.image
    }
}