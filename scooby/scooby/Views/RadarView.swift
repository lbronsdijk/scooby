//
//  RadarView.swift
//  scooby
//
//  Created by Lloyd Keijzer on 18-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit
import QuartzCore

class RadarView: BaseView {

    var nearestScoobyNameLabel: UILabel!
    var circleContainer: CircleContainerView!
    
    private var radarSpinner: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let radar = UIImageView(frame: CGRectMake(0, 0, frame.height - 150, frame.height - 150))
        radar.center = center
        radar.image = UIImage(named: "Radar")
        addSubview(radar)
        
        radarSpinner = UIImageView(frame: radar.frame)
        radarSpinner.image = UIImage(named: "RadarSpinner")
        addSubview(radarSpinner)
        
        let nearestScoobyLabel = UILabel(frame: CGRectMake(20, 26, frame.width - 40, 80))
        nearestScoobyLabel.font = UIFont(name: FONT_AVENIRLIGHT, size: 16)
        nearestScoobyLabel.textColor = UIColor(hexString: COLOR_WHITE)
        nearestScoobyLabel.text = "Nearest Scooby"
        nearestScoobyLabel.textAlignment = .Left
        nearestScoobyLabel.numberOfLines = 1
        nearestScoobyLabel.sizeToFit()
        addSubview(nearestScoobyLabel)
        
        nearestScoobyNameLabel = UILabel(frame: CGRectMake(20, nearestScoobyLabel.frame.origin.y + nearestScoobyLabel.frame.height, frame.width - 40, 80))
        nearestScoobyNameLabel.font = UIFont(name: FONT_AVENIRHEAVY, size: 20)
        nearestScoobyNameLabel.textColor = UIColor(hexString: COLOR_WHITE)
        nearestScoobyNameLabel.textAlignment = .Left
        addSubview(nearestScoobyNameLabel)
        
        circleContainer = CircleContainerView(frame: CGRectMake(0, 0, frame.width, frame.height))
        addSubview(circleContainer)
    }
    
    func changeNearestScoobyName(name: String) {
        nearestScoobyNameLabel.text = "\(name)"
        nearestScoobyNameLabel.numberOfLines = 1
        nearestScoobyNameLabel.sizeToFit()
    }
    
    func animateRadar() {
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Float(M_PI * 2.0)
        rotationAnimation.duration = 3
        rotationAnimation.repeatCount = Float.infinity
        
        self.radarSpinner.layer.addAnimation(rotationAnimation, forKey: nil)
    }
    
    
}
