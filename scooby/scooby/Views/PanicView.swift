//
//  PanicView.swift
//  scooby
//
//  Created by Lloyd Keijzer on 21-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit

class PanicView: BaseView {

    var rocket: UIImageView!
    var moonButton: RoundedButton!
    var fadeView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        fadeView = UIView(frame: frame)
        addSubview(fadeView)
        
        let panicTitle = UILabel(frame: CGRectMake(0, 0, frame.width - 120, 80))
        panicTitle.font = UIFont(name: FONT_AVENIRHEAVY, size: (IS_IPHONE4) ? 32 : 36)
        panicTitle.textColor = UIColor(hexString: COLOR_WHITE)
        panicTitle.text = "Panic!"
        panicTitle.textAlignment = .Center
        panicTitle.numberOfLines = 1
        panicTitle.sizeToFit()
        panicTitle.center = CGPointMake(center.x, ((IS_IPHONE4) ? 44 : 64) + panicTitle.frame.height / 2)
        fadeView.addSubview(panicTitle)
        
        let description = UILabel(frame: CGRectMake(0, 0, frame.width - ((IS_IPHONE4 || IS_IPHONE5) ? 100 : 140), 80))
        description.font = UIFont(name: FONT_AVENIRLIGHT, size: ((IS_IPHONE4) ? 18 : 20))
        description.textColor = UIColor(hexString: COLOR_WHITE)
        description.text = "Are you sure you want to leave your Scooby crew?"
        description.textAlignment = .Center
        description.numberOfLines = 2
        description.sizeToFit()
        description.center = CGPointMake(center.x, panicTitle.frame.origin.y + panicTitle.frame.height + (description.frame.height / 2) + 5)
        fadeView.addSubview(description)
        
        rocket = UIImageView(frame: CGRectMake(0, 0, 85, 87))
        rocket.center = center
        rocket.image = UIImage(named: "PanicShuttle")
        addSubview(rocket)
        
        let moon = UIImageView(frame: CGRectMake(0, 0, 33, 33))
        moon.center = CGPointMake(center.x - 20, center.y - 50)
        moon.image = UIImage(named: "PanicMoon")
        fadeView.addSubview(moon)
        
        moonButton = RoundedButton(yPosition: 0)
        moonButton.center = CGPointMake(center.x, frame.height - (frame.height / 4))
        moonButton.backgroundColor = UIColor(hexString: COLOR_WHITE)
        moonButton.setTitleColor(UIColor(hexString: COLOR_BLACK)!)
        moonButton.setTitle("Take me to the moon")
        fadeView.addSubview(moonButton)
        
        let neverReturn = UILabel(frame: CGRectMake(0, 0, frame.width - ((IS_IPHONE4 || IS_IPHONE5) ? 100 : 140), 80))
        neverReturn.font = UIFont(name: FONT_AVENIRLIGHT, size: ((IS_IPHONE4) ? 18 : 20))
        neverReturn.textColor = UIColor(hexString: COLOR_WHITE)
        neverReturn.text = "... and never return."
        neverReturn.textAlignment = .Center
        neverReturn.numberOfLines = 1
        neverReturn.sizeToFit()
        neverReturn.center = CGPointMake(center.x, moonButton.frame.origin.y + moonButton.frame.height + (neverReturn.frame.height / 2) + 20)
        fadeView.addSubview(neverReturn)
    }

}
