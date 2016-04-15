//
//  RoundedButton.swift
//  scooby
//
//  Created by Lloyd Keijzer on 15-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel?.font = UIFont(name: FONT_AVENIRHEAVY, size: 20)
        self.titleLabel?.numberOfLines = 0;
        self.layer.cornerRadius = 7
        self.layer.shadowColor = UIColor(hexString: COLOR_BLACK)?.CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 3.0);
        self.layer.shadowOpacity = 0.2;
        self.layer.shadowRadius = 0.0;
    }
    
    convenience init(yPosition: CGFloat) {
        
        self.init(frame: CGRectMake(
            ((!IS_IPHONE4 && !IS_IPHONE5) ? 60 : 50),
            yPosition,
            SCREEN_WIDTH - ((!IS_IPHONE4 && !IS_IPHONE5) ? 120 : 100),
            64
        ))
    }
    
    func setTitle(title: String) {
        self.setTitle(title, forState: .Normal)
        self.setTitle(title, forState: .Selected)
        self.setTitle(title, forState: .Highlighted)
    }
    
    func setTitleColor(color: UIColor) {
        self.setTitleColor(color, forState: .Normal)
        self.setTitleColor(color, forState: .Selected)
        self.setTitleColor(color, forState: .Highlighted)
    }
    
    func enable() {
        self.enabled = true
        UIView.animateWithDuration(0.3) {
            self.alpha = 1
        }
    }
    
    func disable() {
        self.enabled = false
        UIView.animateWithDuration(0.3) { 
            self.alpha = 0.1
        }
    }
}
