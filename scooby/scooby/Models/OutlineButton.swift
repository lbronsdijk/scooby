//
//  OutlineButton.swift
//  scooby
//
//  Created by Lloyd Keijzer on 13-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit
import ionicons

class OutlineButton: UIButton {

    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel?.font = UIFont(name: FONT_OPENSANSREGULAR, size: 17)
        self.titleLabel?.numberOfLines = 0;
        self.autoresizingMask = [.FlexibleWidth, .FlexibleTopMargin]
        self.layer.borderColor = UIColor(hexString: COLOR_BLACK)!.CGColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 7
    }
    
    convenience init(frame: CGRect, iconName: String, tintColor: UIColor) {
        
        self.init(frame: frame)
        
        self.setImage(IonIcons.imageWithIcon(
            iconName,
            size: 34.0,
            color: tintColor
        ), forState: .Normal)
        self.setImage(IonIcons.imageWithIcon(
            iconName,
            size: 34.0,
            color: tintColor
        ), forState: .Selected)
        self.setImage(IonIcons.imageWithIcon(
            iconName,
            size: 34.0,
            color: tintColor
        ), forState: .Highlighted)
        
        self.setTitleColor(tintColor, forState: .Normal)
        self.setTitleColor(tintColor, forState: .Selected)
        self.setTitleColor(tintColor, forState: .Highlighted)
        
        self.layer.borderColor = tintColor.CGColor
    }

}
