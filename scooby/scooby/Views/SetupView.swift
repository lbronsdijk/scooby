//
//  SetupView.swift
//  scooby
//
//  Created by Lloyd Keijzer on 15-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit

class SetupView: BaseView {

    var nameTextField: UITextField!
    var doneButton: RoundedButton!
    var container: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(hexString: COLOR_LIGHTGRAY)
        
        container = UIView(frame: CGRectMake(0, 0, frame.width, frame.height))
        addSubview(container)
        
        let logo = UIImageView(frame: CGRectMake(0, 0, 140, 82))
        logo.center = CGPointMake(center.x, frame.height / 5)
        logo.image = UIImage(named: "LogoRed")
        container.addSubview(logo)
        
        let description = UILabel(frame: CGRectMake(0, 0, frame.width - 120, 80))
        description.center = CGPointMake(center.x, center.y - (description.frame.height / 2))
        description.font = UIFont(name: FONT_AVENIRHEAVY, size: 24)
        description.textColor = UIColor(hexString: COLOR_RED)
        description.text = "Scooby Do,\nwho are you?"
        description.textAlignment = .Center
        description.numberOfLines = 2
        container.addSubview(description)
        
        doneButton = RoundedButton(yPosition: 0)
        doneButton.center = CGPointMake(center.x, frame.height - (frame.height / 6))
        doneButton.backgroundColor = UIColor(hexString: COLOR_RED)
        doneButton.setTitleColor(UIColor(hexString: COLOR_WHITE)!)
        doneButton.setTitle("Done!")
        container.addSubview(doneButton)
        
        nameTextField = UITextField(frame: CGRectMake(0, 0, frame.width - 80, 64))
        nameTextField.center = CGPointMake(center.x, doneButton.center.y - (description.center.y / 2))
        nameTextField.textAlignment = .Center
        nameTextField.font = UIFont(name: FONT_AVENIRLIGHT, size: 24)
        nameTextField.textColor = UIColor(hexString: COLOR_RED)
        nameTextField.returnKeyType = .Done
        nameTextField.keyboardType = .ASCIICapable
        nameTextField.placeholder = "Your Scooby name"
        nameTextField.attributedPlaceholder = NSAttributedString(
            string: nameTextField.placeholder!,
            attributes:[
                NSForegroundColorAttributeName: UIColor(hexString: COLOR_RED)!
            ]
        )
        nameTextField.setBottomBorder(COLOR_RED)
        container.addSubview(nameTextField)
    }
}
