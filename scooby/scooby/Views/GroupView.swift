//
//  GroupView.swift
//  scooby
//
//  Created by Lloyd Keijzer on 13-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit

class GroupView: BaseView {

    var continueButton: RoundedButton!
    var lastJoinedScoobyNameLabel: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if GroupViewController.group == nil {
            return
        }
        
        let addScoobies = UILabel(frame: CGRectMake(0, 0, frame.width - 120, 80))
        addScoobies.font = UIFont(name: FONT_AVENIRHEAVY, size: (IS_IPHONE4) ? 32 : 36)
        addScoobies.textColor = UIColor(hexString: COLOR_WHITE)
        addScoobies.text = "Add Scoobies"
        addScoobies.textAlignment = .Center
        addScoobies.numberOfLines = 1
        addScoobies.sizeToFit()
        addScoobies.center = CGPointMake(center.x, ((IS_IPHONE4) ? 44 : 64) + addScoobies.frame.height / 2)
        addSubview(addScoobies)
        
        let description = UILabel(frame: CGRectMake(0, 0, frame.width - ((IS_IPHONE4 || IS_IPHONE5) ? 100 : 140), 80))
        description.font = UIFont(name: FONT_AVENIRLIGHT, size: ((IS_IPHONE4) ? 18 : 20))
        description.textColor = UIColor(hexString: COLOR_WHITE)
        description.text = "Let other Scoobies scan this code."
        description.textAlignment = .Center
        description.numberOfLines = 2
        description.sizeToFit()
        description.center = CGPointMake(center.x, addScoobies.frame.origin.y + addScoobies.frame.height + (description.frame.height / 2) + 5)
        addSubview(description)
        
        let qrCode = UIImageView(frame: CGRectMake(0, 0, frame.width - ((IS_IPHONE4 || IS_IPHONE5) ? 140 : 160), frame.width - ((IS_IPHONE4 || IS_IPHONE5) ? 140 : 160)))
        qrCode.center = center
        qrCode.image = GroupViewController.group?.qrCode
        addSubview(qrCode)
        
        continueButton = RoundedButton(yPosition: SCREEN_HEIGHT - ((IS_IPHONE4) ? 84 : 104))
        continueButton.center = CGPointMake(center.x, continueButton.center.y)
        continueButton.backgroundColor = UIColor(hexString: COLOR_WHITE)
        continueButton.setTitleColor(UIColor(hexString: COLOR_BLACK)!)
        continueButton.setTitle("Continue partying!")
        addSubview(continueButton)
        
        let lastJoinedLabel = UILabel(frame: CGRectMake(0, 0, frame.width - ((IS_IPHONE4 || IS_IPHONE5) ? 100 : 140), 80))
        lastJoinedLabel.font = UIFont(name: FONT_AVENIRLIGHT, size: 16)
        lastJoinedLabel.textColor = UIColor(hexString: COLOR_WHITE)
        lastJoinedLabel.text = "Last joined Scooby:"
        lastJoinedLabel.textAlignment = .Center
        lastJoinedLabel.numberOfLines = 1
        lastJoinedLabel.sizeToFit()
        lastJoinedLabel.center = CGPointMake(center.x, ((continueButton.frame.origin.y - (qrCode.frame.origin.y + qrCode.frame.height)) / 2) + qrCode.frame.origin.y + qrCode.frame.height - 20)
        addSubview(lastJoinedLabel)
        
        lastJoinedScoobyNameLabel = UILabel(frame: CGRectMake(0, lastJoinedLabel.frame.origin.y + lastJoinedLabel.frame.height, frame.width - 120, 80))
        lastJoinedScoobyNameLabel.font = UIFont(name: FONT_AVENIRHEAVY, size: 24)
        lastJoinedScoobyNameLabel.textColor = UIColor(hexString: COLOR_WHITE)
        lastJoinedScoobyNameLabel.textAlignment = .Center
        addSubview(lastJoinedScoobyNameLabel)
    }
    
    func changeLastJoinedName(name: String) {
        lastJoinedScoobyNameLabel.text = "\(name)"
        lastJoinedScoobyNameLabel.numberOfLines = 1
        lastJoinedScoobyNameLabel.sizeToFit()
        lastJoinedScoobyNameLabel.center = CGPointMake(center.x, lastJoinedScoobyNameLabel.center.y)
    }
}
