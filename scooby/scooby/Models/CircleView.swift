//
//  CircleView.swift
//  scooby
//
//  Created by Lloyd Keijzer on 20-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit

@objc protocol CircleProtocol {
    optional func circleDidMoved(circle: CircleView)
    optional func circleReleased(circle: CircleView)
    optional func circleIsTapped(circle: CircleView)
}

class CircleView: UIView {

    var delegate: CircleProtocol?
    var lineIsVisible: Bool = true
    var draggable: Bool = true
    
    private var textLabel: UILabel!
    private var lastLocation:CGPoint = CGPointMake(0, 0)
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if (frame.width != frame.height) {
            self.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.width, frame.width)
        }
        self.layer.cornerRadius = frame.width / 2
        backgroundColor = UIColor(hexString: COLOR_GREEN)
        self.layer.borderColor = UIColor(hexString: COLOR_WHITE)?.CGColor
        self.layer.borderWidth = 3
        
        textLabel = UILabel(frame: CGRectMake(0, 0, frame.width, frame.height))
        textLabel.font = UIFont(name: FONT_AVENIRHEAVY, size: 20)
        textLabel.textColor = UIColor(hexString: COLOR_WHITE)
        textLabel.textAlignment = .Center
        addSubview(textLabel)
        
        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(detectPan(_:)))
        self.gestureRecognizers = [panRecognizer]
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    convenience init(position: CGPoint, big: Bool) {
        self.init(frame: CGRectMake(
            position.x - ((big) ? 50 : 30),
            position.y - ((big) ? 50 : 30),
            (big) ? 100 : 60,
            (big) ? 100 : 60)
        )
        textLabel.font = UIFont(name: FONT_AVENIRHEAVY, size: (big) ? 28 : 16)
    }
    
    func changeTextLabel(text: String) {
        textLabel.text = "\(text)"
    }
    
    func detectPan(recognizer:UIPanGestureRecognizer) {
        
        if !draggable {
            return
        }
        
        if(recognizer.state == .Began) {
            self.lineIsVisible = false
            lastLocation = self.center
        } else if(recognizer.state == .Ended) {
            self.lineIsVisible = false
            if self.delegate != nil {
                self.delegate!.circleDidMoved?(self)
                self.delegate!.circleReleased?(self)
            }
            UIView.animateWithDuration(2.0, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 3.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: ({
                self.center = self.lastLocation
            }), completion: { (Bool) in
                self.lineIsVisible = true
                if self.delegate != nil {
                    self.delegate!.circleDidMoved?(self)
                }
            })
        } else {
            let translation  = recognizer.translationInView(self.superview!)
            self.center = CGPointMake(lastLocation.x + translation.x, lastLocation.y + translation.y)
            if delegate != nil {
                delegate!.circleDidMoved?(self)
            }
        }
    }
    
    func tapped() {
        if self.delegate != nil {
            self.delegate!.circleIsTapped?(self)
        }
    }
}