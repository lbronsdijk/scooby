//
//  ViewController.swift
//  scooby
//
//  Created by Lloyd Keijzer on 11-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit
import MultipeerConnectivity
import ionicons

class DashboardViewController: BaseViewController {

    var dashboardView : DashboardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initialize view
        dashboardView = DashboardView(frame: viewRect)
        view.addSubview(dashboardView)
    }
}

