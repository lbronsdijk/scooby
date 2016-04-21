//
//  Datacalls.swift
//  scooby
//
//  Created by Lloyd Keijzer on 14-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class Datacalls {
    
    // MARK: Process incoming data
    
    static func processData(data: NSData, sender: MCPeerID) {
        
        let dataDict: NSDictionary! = NSKeyedUnarchiver.unarchiveObjectWithData(data)! as? NSDictionary
        print("Received data from: \(sender.displayName) data: \(dataDict)")
        
        switch dataDict?.objectForKey("call") as! String {
            case "join":
                Datacalls.joinCall(sender, data: dataDict)
                break
            case "joinRequest":
                Datacalls.joinRequestCall(sender, data: dataDict)
                break
            case "joinRequestAccepted":
                Datacalls.joinRequestAcceptedCall(sender, data: dataDict)
                break
            case "areYouInGroup":
                Datacalls.areYouInGroupCall(sender, data: dataDict)
                break
            default:
                break
        }
    }
    
    // MARK: Requests
    
    private static func joinCall(sender: MCPeerID, data: NSDictionary) {
        
        let name: String? = data.objectForKey("name") as! String?
        
        if name != nil {
            
            for peer: MCPeerID in MultipeerController.sharedInstance.peers {
                if (peer.displayName == name) {
                    Datacalls.sendData(
                        "areYouInGroup",
                        data: [
                            "groupId" : (GroupViewController.group?.groupId)!
                        ],
                        receiver: peer,
                        successHandler: {
                            print("Asking \(name) if he/she is in our group")
                        },
                        errorHandler: { (error) in }
                    )
                }
            }
        } else {
            GroupViewController.group?.join(sender)
        }
    }
    
    private static func joinRequestCall(sender: MCPeerID, data: NSDictionary) {
        
        let groupId = data.objectForKey("groupId") as! String
        
        if GroupViewController.group != nil && GroupViewController.group?.groupId == groupId {
            
            var namesOfGroupMembers = [String]()
            
            for member: GroupMember in (GroupViewController.group?.members)! {
                if member.peerId != MultipeerController.sharedInstance.peerId {
                    namesOfGroupMembers.append(member.peerId.displayName)
                }
                
            }
            
            Datacalls.sendData(
                "joinRequestAccepted",
                data: [
                    "groupId" : groupId,
                    "groupMembers" : namesOfGroupMembers
                ],
                receiver: sender, successHandler: {
                    GroupViewController.group?.join(sender)
                    
                    for member: GroupMember in (GroupViewController.group?.members)! {
                        
                        if member.peerId == MultipeerController.sharedInstance.peerId {
                            continue
                        }
                        
                        Datacalls.sendData(
                            "join",
                            data: ["name" : sender.displayName],
                            receiver: member.peerId,
                            successHandler: {
                                print("Confirm to \(sender.displayName) that i am part of the group")
                            },
                            errorHandler: { (error) in }
                        )
                    }
                },
                errorHandler: { (error) in }
            )
        }
    }
    
    private static func joinRequestAcceptedCall(sender: MCPeerID, data: NSDictionary) {
        
        let groupId = data.objectForKey("groupId") as! String
        let groupMembers = data.objectForKey("groupMembers") as! [String]
        
        GroupViewController.group = Group(creator: sender)
        GroupViewController.group?.groupId = groupId
        GroupViewController.group?.join(MultipeerController.sharedInstance.peerId)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let navigationController: NavigationController = (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController as! NavigationController
            var viewController: BaseViewController = navigationController.viewControllers.last as! BaseViewController
            
            if viewController.presentedViewController != nil {
                viewController = (viewController.presentedViewController as! NavigationController).viewControllers.last as! BaseViewController
            }
            
            dispatch_async(dispatch_get_main_queue(), {
                let radarNavigationController = NavigationController(rootViewController: RadarViewController())
                viewController.presentViewController(radarNavigationController, animated: true, completion: nil)
            })
        }
        
        for member: String in groupMembers {
            
            for peer: MCPeerID in MultipeerController.sharedInstance.peers {
                if (peer.displayName == member) {
                    Datacalls.sendData(
                        "areYouInGroup",
                        data: [
                            "groupId" : groupId
                        ],
                        receiver: peer,
                        successHandler: {
                            print("Asking \(member) if he/she is in our group")
                        },
                        errorHandler: { (error) in }
                    )
                }
            }
        }
    }
    
    private static func areYouInGroupCall(sender: MCPeerID, data: NSDictionary) {
        
        let groupId = data.objectForKey("groupId") as! String
        
        if GroupViewController.group != nil && GroupViewController.group?.groupId == groupId {
            
            Datacalls.sendData(
                "join",
                data: NSDictionary(),
                receiver: sender,
                successHandler: {
                    print("Confirm to \(sender.displayName) that i am part of the group")
                },
                errorHandler: { (error) in }
            )
        }
    }

    
    // MARK: Send data
    
    private static func sendData(call: String, data: NSDictionary, receiver: MCPeerID, successHandler: () -> Void, errorHandler: (error: AnyObject) -> Void) {
        
        let mutableData = NSMutableDictionary(dictionary: data)
        mutableData.setObject(call, forKey: "call")
        
        do {
            let archivedData: NSData = NSKeyedArchiver.archivedDataWithRootObject(mutableData.copy())
            try MultipeerController.sharedInstance.session.sendData(
                archivedData,
                toPeers: [receiver],
                withMode: .Reliable
            )
            successHandler()
        } catch {
            let errorMessage = "Could not send data to: \(receiver.displayName)"
            print(errorMessage)
            errorHandler(error: errorMessage)
        }
    }
}