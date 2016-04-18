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
        
        animateRadar()
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
