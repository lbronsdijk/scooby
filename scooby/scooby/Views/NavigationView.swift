//
//  NavigationView.swift
//  scooby
//
//  Created by Lloyd Keijzer on 21-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit

class NavigationView: BaseView {

    var addButton, panicButton: RoundedButton!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Dark))
        visualEffectView.frame = self.frame
        addSubview(visualEffectView)
        
        let logo = UIImageView(frame: CGRectMake(0, 0, 140, 82))
        logo.center = CGPointMake(center.x, frame.height / 5)
        logo.image = UIImage(named: "LogoBlank")
        addSubview(logo)
        
        addButton = RoundedButton(yPosition: 0)
        addButton.center = CGPointMake(center.x, center.y)
        addButton.backgroundColor = UIColor(hexString: COLOR_WHITE)
        addButton.setTitleColor(UIColor(hexString: COLOR_BLACK)!)
        addButton.setTitle("Add Scoobies")
        addSubview(addButton)
        
        let or = UILabel(frame: CGRectMake(0, 0, frame.width - 120, 50))
        or.font = UIFont(name: FONT_AVENIRLIGHT, size: 20)
        or.textColor = UIColor(hexString: COLOR_WHITE)
        or.text = "or"
        or.textAlignment = .Center
        or.numberOfLines = 1
        or.center = CGPointMake(center.x, addButton.frame.origin.y + addButton.frame.height + 25)
        addSubview(or)
        
        panicButton = RoundedButton(yPosition: addButton.frame.origin.y + addButton.frame.height + 50)
        panicButton.center = CGPointMake(center.x, panicButton.center.y)
        panicButton.backgroundColor = UIColor(hexString: COLOR_RED)
        panicButton.setTitleColor(UIColor(hexString: COLOR_WHITE)!)
        panicButton.setTitle("Panic! Leave crew")
        addSubview(panicButton)
    }
}
