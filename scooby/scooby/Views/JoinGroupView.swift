//
//  JoinGroupView.swift
//  scooby
//
//  Created by Lloyd Keijzer on 18-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit
import SwiftQRCode

class JoinGroupView: BaseView {

    let scanner = QRCode()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let joinScoobyCrew = UILabel(frame: CGRectMake(0, 0, frame.width - 120, 80))
        joinScoobyCrew.font = UIFont(name: FONT_AVENIRHEAVY, size: (IS_IPHONE4) ? 32 : 36)
        joinScoobyCrew.textColor = UIColor(hexString: COLOR_WHITE)
        joinScoobyCrew.text = "Join a crew"
        joinScoobyCrew.textAlignment = .Center
        joinScoobyCrew.numberOfLines = 1
        joinScoobyCrew.sizeToFit()
        joinScoobyCrew.center = CGPointMake(center.x, ((IS_IPHONE4) ? 44 : 64) + joinScoobyCrew.frame.height / 2)
        addSubview(joinScoobyCrew)
        
        let description = UILabel(frame: CGRectMake(0, 0, frame.width - ((IS_IPHONE4 || IS_IPHONE5) ? 100 : 140), 80))
        description.font = UIFont(name: FONT_AVENIRLIGHT, size: ((IS_IPHONE4) ? 18 : 20))
        description.textColor = UIColor(hexString: COLOR_WHITE)
        description.text = "Scan the Scooby code to join."
        description.textAlignment = .Center
        description.numberOfLines = 1
        description.sizeToFit()
        description.center = CGPointMake(center.x, joinScoobyCrew.frame.origin.y + joinScoobyCrew.frame.height + (description.frame.height / 2) + 5)
        addSubview(description)
        
        let scanArea = UIView(frame: CGRectMake(0, 0, frame.width - 40, frame.width - 40))
        scanArea.center = CGPointMake(center.x, center.y + (frame.width / 6))
        addSubview(scanArea)
        
        scanner.prepareScan(scanArea) { (stringValue) -> () in
            print("scanned: \(stringValue)")
            if stringValue.rangeOfString("Scooby") != nil{
                UIApplication.sharedApplication().openURL(NSURL(string: stringValue)!)
            }
        }
        
        scanner.scanFrame = scanArea.bounds
        
        let focus = UIImageView(frame: CGRectMake(50, 50, scanArea.frame.width - 100, scanArea.frame.height - 100))
        focus.image = UIImage(named: "Focus")
        scanArea.addSubview(focus)
    }
}
