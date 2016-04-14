//
//  DashboardView.swift
//  scooby
//
//  Created by Lloyd Keijzer on 12-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit

class DashboardView: BaseView {

    var peerTable : UITableView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        peerTable = UITableView(frame: CGRectMake(0, 0, frame.width, frame.height), style: .Grouped)
        peerTable.backgroundColor = UIColor(hexString: COLOR_DARKGRAY)
        addSubview(peerTable)
    }
}
