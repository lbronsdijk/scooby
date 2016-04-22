//
//  CircleDetailView.swift
//  scooby
//
//  Created by Lloyd Keijzer on 20-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit
import ionicons

class CircleDetailView: UIView {

    var arrow: UIImageView!
    var name, distance: UILabel!
    var member: GroupMember?
    private var contentView, backgroundView: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        
        backgroundView = UIView(frame: frame)
        backgroundView.backgroundColor = UIColor.blackColor()
        backgroundView.alpha = 0.5
        backgroundView.userInteractionEnabled = true
        addSubview(backgroundView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(close))
        backgroundView.addGestureRecognizer(tapGesture)
        
        contentView = UIView(frame: CGRectMake(0, frame.height - 400, frame.width, 400))
        contentView.backgroundColor = UIColor(hexString: COLOR_LIGHTGRAY)
        addSubview(contentView)
        
        let dragIndicator = UIImageView(frame: CGRectMake(0, 10, 30, 30))
        dragIndicator.center = CGPointMake(contentView.center.x, dragIndicator.center.y)
        dragIndicator.image = IonIcons.imageWithIcon(
            ion_drag,
            iconColor: UIColor(hexString: COLOR_GRAY)!,
            iconSize: 30,
            imageSize: CGSizeMake(30, 30)
        )
        contentView.addSubview(dragIndicator)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(close))
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Down
        contentView.addGestureRecognizer(swipeGesture)
        
        arrow = UIImageView(frame: CGRectMake((contentView.frame.width - 57) / 2, ((contentView.frame.width - 82) / 2) + 20, 57, 82))
        arrow.image = UIImage(named: "LocationArrow")
        contentView.addSubview(arrow)
        
        name = UILabel(frame: CGRectMake(0, dragIndicator.frame.origin.y + dragIndicator.frame.height + 20, frame.width - ((IS_IPHONE4 || IS_IPHONE5) ? 100 : 140), 80))
        name.font = UIFont(name: FONT_AVENIRHEAVY, size: ((IS_IPHONE4) ? 22 : 24))
        name.textColor = UIColor(hexString: COLOR_RED)
        name.text = "Luc"
        name.textAlignment = .Center
        name.numberOfLines = 1
        name.sizeToFit()
        name.center = CGPointMake(center.x, name.center.y)
        contentView.addSubview(name)
        
        let line = UIView(frame: CGRectMake((frame.width - (25)) / 2, name.frame.origin.y + name.frame.height + 5, 25, 1))
        line.backgroundColor = UIColor(hexString: COLOR_LINEGRAY)
        line.alpha = 0.33
        contentView.addSubview(line)
        
        distance = UILabel(frame: CGRectMake(0, 0, frame.width - ((IS_IPHONE4 || IS_IPHONE5) ? 100 : 140), 80))
        distance.font = UIFont(name: FONT_AVENIRHEAVY, size: ((IS_IPHONE4) ? 22 : 24))
        distance.textColor = UIColor(hexString: COLOR_BLACK)
        distance.text = "230 meters away"
        distance.textAlignment = .Center
        distance.numberOfLines = 1
        distance.sizeToFit()
        distance.center = CGPointMake(center.x, arrow.frame.origin.y + arrow.frame.height + (distance.frame.height / 2) + 10)
        contentView.addSubview(distance)
        
        let showMapButton = RoundedButton(frame: CGRectMake(20, contentView.frame.height - 64 - 20, (contentView.frame.width - 40 - 10) / 2, 64))
        showMapButton.setTitle("Show map")
        showMapButton.backgroundColor = UIColor(hexString: COLOR_GREEN)
        showMapButton.setTitleColor(UIColor(hexString: COLOR_WHITE)!)
        contentView.addSubview(showMapButton)
        
        let notifyButton = RoundedButton(frame: CGRectMake(20 + 10 + (contentView.frame.width - 40 - 10) / 2, contentView.frame.height - 64 - 20, (contentView.frame.width - 40 - 10) / 2, 64))
        notifyButton.setTitle("Notify")
        notifyButton.backgroundColor = UIColor(hexString: COLOR_RED)
        notifyButton.setTitleColor(UIColor(hexString: COLOR_WHITE)!)
        contentView.addSubview(notifyButton)
        
        self.hidden = true
    }
    
    func open() {
        self.hidden = false
        backgroundView.alpha = 0
        contentView.frame = CGRectMake(
            contentView.frame.origin.x,
            frame.height,
            contentView.frame.width,
            contentView.frame.height
        )
        UIView.animateWithDuration(0.4) {
            self.backgroundView.alpha = 0.5
            self.contentView.frame = CGRectMake(
                self.contentView.frame.origin.x,
                self.frame.height - self.contentView.frame.height,
                self.contentView.frame.width,
                self.contentView.frame.height
            )
        }
    }
    
    func close() {
        UIView.animateWithDuration(0.4, animations: {
            self.backgroundView.alpha = 0
            self.contentView.frame = CGRectMake(
                self.contentView.frame.origin.x,
                self.frame.height,
                self.contentView.frame.width,
                self.contentView.frame.height
            )
        }) { (Bool) in
            self.hidden = true
        }
    }
    
    func changeName(displayName: String) {
        
        name.text = displayName
        name.numberOfLines = 1
        name.sizeToFit()
        name.center = CGPointMake(center.x, name.center.y)
    }
    
    func changeDistance(meters: Int) {
        distance.text = "\(meters) meters away"
        distance.numberOfLines = 1
        distance.sizeToFit()
        distance.center = CGPointMake(center.x, distance.center.y)
    }
}
