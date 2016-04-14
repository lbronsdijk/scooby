//
//  GroupView.swift
//  scooby
//
//  Created by Lloyd Keijzer on 13-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit
import ionicons

class GroupPortalView: BaseView {

    var createButton, joinButton: OutlineButton!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createButton = OutlineButton(
            frame: CGRectMake(0, 0, frame.width - 40, 64),
            iconName: ion_ios_plus_empty,
            tintColor: UIColor(hexString: COLOR_RED)!
        )
        createButton.center = CGPointMake(center.x, center.y - 42)
        createButton.setTitle("Create Group", forState: .Normal)
        addSubview(createButton)
        
        joinButton = OutlineButton(
            frame: CGRectMake(0, 0, frame.width - 40, 64),
            iconName: ion_ios_people_outline,
            tintColor: UIColor(hexString: COLOR_RED)!
        )
        joinButton.center = CGPointMake(center.x, center.y + 42)
        joinButton.setTitle("Join Group", forState: .Normal)
        addSubview(joinButton)
    }
}
