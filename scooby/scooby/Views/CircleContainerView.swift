//
//  CircleContainerView.swift
//  scooby
//
//  Created by Lloyd Keijzer on 20-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit
import ionicons
import MultipeerConnectivity
import CoreLocation

class CircleContainerView: UIView, CircleProtocol {

    var peerCircles = [CircleView]()
    private var meCircle: CircleView?
    private var minY, maxY: CGFloat!
    private var dashedBorder: CAShapeLayer!
    private var infoArea: UIImageView!
    var detailView: CircleDetailView!
    private var trigger: Bool = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        minY = 100
        maxY = minY + (frame.height - 200)
        
        self.backgroundColor = UIColor.clearColor()
        
        // info area
        infoArea = UIImageView(frame: CGRectMake(0, 0, 60, 60))
        infoArea.center = CGPointMake(center.x, (75 / 2) + (frame.height - 75))
        infoArea.image = IonIcons.imageWithIcon(
            ion_ios_information_empty,
            iconColor: UIColor(hexString: COLOR_WHITE)!,
            iconSize: 60, imageSize: CGSizeMake(60, 60)
        )
        
        dashedBorder = CAShapeLayer()
        let frameSize = infoArea.frame.size
        let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)
        
        dashedBorder.bounds = shapeRect
        dashedBorder.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        dashedBorder.fillColor = UIColor.clearColor().CGColor
        dashedBorder.strokeColor = UIColor(hexString: COLOR_WHITE)!.CGColor
        dashedBorder.lineWidth = 2
        dashedBorder.lineJoin = kCALineJoinRound
        dashedBorder.lineDashPattern = [6,3]
        dashedBorder.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 30).CGPath
        
        infoArea.layer.addSublayer(dashedBorder)
        
        addSubview(infoArea)
        
        // add circles for group members
        for member: GroupMember in (GroupViewController.group?.members)! {
            
            if member.peerId == MultipeerController.sharedInstance.peerId {
                // me circle
                meCircle = CircleView(position: CGPointMake(
                    center.x,
                    center.y), big: true)
                let peerDisplayName = MultipeerController.displayName!
                meCircle!.changeTextLabel("\(peerDisplayName.substringToIndex(peerDisplayName.startIndex.advancedBy(2)).uppercaseString)")
                meCircle!.draggable = false
                addSubview(meCircle!)
            } else {
                // groupmember circle
                if member.circleView == nil { addCircle(member) }
            }
        }
        
        // debug circle
        if RadarViewController.DEBUG_MODE {
            let debugPeerId = MCPeerID(displayName: "Debug")
            let debugGroupMember = GroupMember(peerId: debugPeerId)
            debugGroupMember.location = CLLocationCoordinate2DMake(52.044888, 4.6480753) // waddinxveen station
            addCircle(debugGroupMember)
        }
        
        // detail
        detailView = CircleDetailView(frame: self.frame)
        addSubview(detailView)
    }
    
    func addCircle(member: GroupMember) {

        let circle = CircleView(position: self.center, big: false)
        let peerDisplayName = member.peerId.displayName
        circle.changeTextLabel("\(peerDisplayName.substringToIndex(peerDisplayName.startIndex.advancedBy(2)).uppercaseString)")
        circle.delegate = self
        
        if meCircle == nil {
            addSubview(circle)
        } else {
            insertSubview(circle, belowSubview: meCircle!)
        }
        
        peerCircles.append(circle)
        member.circleView = circle
    }
    
    func circleDidMoved(circle: CircleView) {
        
        setNeedsDisplay()
        
        if CGRectIntersectsRect(circle.frame, infoArea.frame) {
            trigger = true
            UIView.animateWithDuration(0.3, animations: { 
                self.infoArea.transform = CGAffineTransformMakeScale(1.2, 1.2)
            })
        } else {
            trigger = false
            UIView.animateWithDuration(0.3, animations: {
                self.infoArea.transform = CGAffineTransformIdentity
            })
        }
    }
    
    func circleReleased(circle: CircleView) {
        if trigger {
            
            assignMemberToDetail(circle)
            
            detailView.open()
            
            UIView.animateWithDuration(0.3, animations: {
                self.infoArea.transform = CGAffineTransformIdentity
            })
        }
    }
    
    func circleIsTapped(circle: CircleView) {
        
        assignMemberToDetail(circle)
        
        detailView.open()
    }
    
    func assignMemberToDetail(circle: CircleView) {
        
        for member:GroupMember in (GroupViewController.group?.members)! {
            if member.circleView == circle {
                
                detailView.changeName(member.peerId.displayName)
                
                if member.degrees != nil {
                    
                    let radians = CGFloat(LocationController.degreesToRadians((-member.degrees!) + 90))
                    detailView.arrow.transform = CGAffineTransformMakeRotation(radians)
                }
                if member.distance != nil {
                    detailView.changeDistance(Int(member.distance!))
                }
                
                detailView.member = member
                
                break
            }
        }
    }
    
    func moveCircleToDegree(circle: CircleView, degrees: Double) {
        
        if circle.lineIsVisible {
            
            let radians = CGFloat(LocationController.degreesToRadians(degrees))
            
            let radius: CGFloat = 120
            
            var position: CGPoint = CGPointMake(0, 0)
            position.x = (center.x - CGFloat(circle.frame.width / 2)) + radius * CGFloat(cos(-radians))
            position.y = (center.y - CGFloat(circle.frame.height / 2)) + radius * CGFloat(sin(-radians))
            
            circle.frame = CGRectMake(position.x, position.y, circle.frame.width, circle.frame.height)
            
            setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath()
        
        var numberOfLinesToDraw = 0
        
        for peerCircle: CircleView in peerCircles {
            
            if !peerCircle.lineIsVisible {
                continue
            }
            
            path.moveToPoint(CGPoint(x: center.x, y: center.y))
            path.addLineToPoint(CGPoint(x: peerCircle.center.x, y: peerCircle.center.y))
            
            numberOfLinesToDraw += 1
        }
        
        if numberOfLinesToDraw == 0 {
            return
        }
        
        path.closePath()
        
        path.lineWidth = 3
        
        //If you want to stroke it with a red color
        UIColor(hexString: COLOR_WHITE)!.set()
        path.stroke()
    }
}
