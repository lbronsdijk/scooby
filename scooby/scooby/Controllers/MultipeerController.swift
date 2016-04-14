//
//  MultipeerController.swift
//  scooby
//
//  Created by Lloyd Keijzer on 11-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import Foundation
import MultipeerConnectivity

@objc protocol MultipeerDelegate {
    optional func peerDidConnect(peerID: MCPeerID)
    optional func peerIsConnecting(peerID: MCPeerID)
    optional func lostConnectionToPeer(peerID: MCPeerID, index: Int)
}

class MultipeerController : NSObject, MCSessionDelegate, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate {
    
    static var displayName : String?
    static let sharedInstance = MultipeerController()
    
    var peerId : MCPeerID!
    var session : MCSession!
    var advertiser : MCNearbyServiceAdvertiser!
    var browser : MCNearbyServiceBrowser!
    var peers = [MCPeerID]()
    
    var delegate : MultipeerDelegate?
    
    let SERVICE_STRING = "scooby-service"
    
    private override init() {
        
        super.init()
        
        if (MultipeerController.displayName == nil) {
            print("MultipeerController can't be intitialized. Specify the display name first!")
            return
        }
        
        peerId = MCPeerID(displayName: MultipeerController.displayName!)
        
        session = MCSession(peer: peerId)
        session.delegate = self
        
        advertiser = MCNearbyServiceAdvertiser(peer: peerId, discoveryInfo: nil, serviceType: SERVICE_STRING)
        advertiser.delegate = self
        print("Start advertising...")
        advertiser.startAdvertisingPeer()
        
        browser = MCNearbyServiceBrowser(peer: peerId, serviceType: SERVICE_STRING)
        browser.delegate = self
        print("Start browsing...")
        browser.startBrowsingForPeers()
    }
    
    // MARK: MCSessionDelegate
    
    // Remote peer changed state.
    func session(session: MCSession, peer peerID: MCPeerID, didChangeState state: MCSessionState) {
        
        switch(state) {
            case .Connected:
                print("Connected to: \(peerID.displayName)")
                peers.append(peerID)
                if delegate != nil {
                    delegate!.peerDidConnect?(peerID)
                }
                break
            case .Connecting:
                print("Connecting to: \(peerID.displayName)")
                if delegate != nil {
                    delegate!.peerIsConnecting?(peerID)
                }
                break
            case .NotConnected:
                print("Connection lost with: \(peerID.displayName)")
                if let index = peers.indexOf(peerID) {
                    peers.removeAtIndex(index)
                    if delegate != nil {
                        delegate!.lostConnectionToPeer?(peerID, index: index)
                    }
                }
                break
        }
    }
    
    // Received data from remote peer.
    func session(session: MCSession, didReceiveData data: NSData, fromPeer peerID: MCPeerID) {
        Datacalls.processData(data, sender: peerID)
    }
    
    // Received a byte stream from remote peer.
    func session(session: MCSession, didReceiveStream stream: NSInputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
    
    }
    
    
    // Start receiving a resource from remote peer.
    func session(session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, withProgress progress: NSProgress) {
    
    }
    
    // Finished receiving a resource from remote peer and saved the content
    // in a temporary location - the app is responsible for moving the file
    // to a permanent location within its sandbox.
    func session(session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, atURL localURL: NSURL, withError error: NSError?) {
    
    }
    
    // MARK: MCNearbyServiceBrowserDelegate
    
    // Found a nearby advertising peer.
    func browser(browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        print("Found peer: \(peerID.displayName)")
        browser.invitePeer(peerID, toSession: session, withContext: NSData(), timeout: 60)
    }
    
    // A nearby peer has stopped advertising.
    func browser(browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("Lost peer: \(peerID.displayName)")
    }
    
    // MARK: MCNearbyServiceAdvertiserDelegate
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: NSData?, invitationHandler: (Bool, MCSession) -> Void) {
        
        print("Received invite from: \(peerID.displayName)")
        invitationHandler(true, self.session)
    }
}