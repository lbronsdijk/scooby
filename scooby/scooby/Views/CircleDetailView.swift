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
}
