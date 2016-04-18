//
//  DashboardView.swift
//  scooby
//
//  Created by Lloyd Keijzer on 12-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit

class DashboardView: BaseView {
    
    var createButton, joinButton: RoundedButton!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(hexString: COLOR_GREEN)
        
        let welcome = UILabel(frame: CGRectMake(0, 0, frame.width - 120, 80))
        welcome.font = UIFont(name: FONT_AVENIRHEAVY, size: 36)
        welcome.textColor = UIColor(hexString: COLOR_WHITE)
        welcome.text = "Hi \(MultipeerController.displayName!),"
        welcome.textAlignment = .Center
        welcome.numberOfLines = 1
        welcome.sizeToFit()
        welcome.center = CGPointMake(center.x, frame.height / 4)
        addSubview(welcome)
        
        let description = UILabel(frame: CGRectMake(0, 0, frame.width - 120, 80))
        description.font = UIFont(name: FONT_AVENIRLIGHT, size: 20)
        description.textColor = UIColor(hexString: COLOR_WHITE)
        description.text = "What do you wanna do?"
        description.textAlignment = .Center
        description.sizeToFit()
        description.numberOfLines = 1
        description.center = CGPointMake(center.x, welcome.frame.origin.y + welcome.frame.height + (description.frame.height / 2) + 5)
        addSubview(description)
        
        createButton = RoundedButton(yPosition: 0)
        createButton.center = CGPointMake(center.x, center.y)
        createButton.backgroundColor = UIColor(hexString: COLOR_WHITE)
        createButton.setTitleColor(UIColor(hexString: COLOR_RED)!)
        createButton.setTitle("Create a crew")
        addSubview(createButton)
        
        let or = UILabel(frame: CGRectMake(0, 0, frame.width - 120, 50))
        or.font = UIFont(name: FONT_AVENIRLIGHT, size: 20)
        or.textColor = UIColor(hexString: COLOR_WHITE)
        or.text = "or"
        or.textAlignment = .Center
        or.numberOfLines = 1
        or.center = CGPointMake(center.x, createButton.frame.origin.y + createButton.frame.height + 25)
        addSubview(or)
        
        joinButton = RoundedButton(yPosition: createButton.frame.origin.y + createButton.frame.height + 50)
        joinButton.center = CGPointMake(center.x, joinButton.center.y)
        joinButton.backgroundColor = UIColor(hexString: COLOR_WHITE)
        joinButton.setTitleColor(UIColor(hexString: COLOR_BLACK)!)
        joinButton.setTitle("Join a crew")
        addSubview(joinButton)
    }
}
