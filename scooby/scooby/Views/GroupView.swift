//
//  GroupView.swift
//  scooby
//
//  Created by Lloyd Keijzer on 13-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit

class GroupView: BaseView {

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if GroupViewController.group == nil {
            return
        }
        
        let qrCode = UIImageView(frame: CGRectMake(0, 0, frame.width - 88, frame.width - 88))
        qrCode.center = center
        qrCode.image = GroupViewController.group?.qrCode
        addSubview(qrCode)
    }
}
