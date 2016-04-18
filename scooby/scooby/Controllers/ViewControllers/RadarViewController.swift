//
//  RadarViewController.swift
//  scooby
//
//  Created by Lloyd Keijzer on 18-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit
import ionicons

class RadarViewController: BaseViewController {

    var radarView: RadarView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initialize view
        radarView = RadarView(frame: viewRect)
        view.addSubview(radarView)
        // menu button
        let menuButton = UIButton(frame: CGRectMake(0, 0, 44, 44))
        menuButton.setImage(IonIcons.imageWithIcon(
            ion_navicon_round,
            size: 32.0,
            color: UIColor(hexString: COLOR_WHITE)
            ), forState: .Normal)
        menuButton.addTarget(self, action: #selector(toggleMenu), forControlEvents: .TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuButton)
    }
    
    func toggleMenu() {
    
    }
}
