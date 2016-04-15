//
//  SetupViewController.swift
//  scooby
//
//  Created by Lloyd Keijzer on 15-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit

class SetupViewController: BaseViewController, UITextFieldDelegate, KeyboardDelegate {

    var setupView : SetupView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // status bar style
        UIApplication.sharedApplication().statusBarStyle = .Default
        // initialize view
        setupView = SetupView(frame: viewRect)
        view.addSubview(setupView)
        // setting textfield delegate
        setupView.nameTextField.delegate = self
        // targets
        setupView.doneButton.addTarget(self, action: #selector(done), forControlEvents: .TouchUpInside)
        // disable button
        setupView.doneButton.disable()
    }
    
    override func viewWillAppear(animated: Bool) {
        // setting keyboard delegate
        Keyboard.sharedInstance.delegate = self
    }
    
    func keyboardWillShow() {
        
        let old = self.setupView.nameTextField.frame.origin.y
        let new = Keyboard.sharedInstance.rect()!.origin.y - self.setupView.nameTextField.frame.height - 5
        
        if new < old {
            UIView.animateWithDuration(0.3) {
                
                self.setupView.container.frame = CGRectMake(
                    self.setupView.container.frame.origin.x,
                    self.setupView.container.frame.origin.y + (new - old),
                    self.setupView.container.frame.width,
                    self.setupView.container.frame.height
                )
            }
        }
    }
    
    func keyboardWillHide() {
        
        UIView.animateWithDuration(0.3) {
            
            self.setupView.container.frame = CGRectMake(
                self.setupView.container.frame.origin.x,
                0,
                self.setupView.container.frame.width,
                self.setupView.container.frame.height
            )
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (string.rangeOfCharacterFromSet(NSCharacterSet.letterCharacterSet()) != nil || string == " " || string == "") {
            if ((textField.text!.characters.count + string.characters.count - range.length) > 0) {
                setupView.doneButton.enable()
            } else {
                setupView.doneButton.disable()
            }
            return true
        } else {
            return false
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func done() {
        MultipeerController.displayName = setupView.nameTextField.text
        self.presentViewController(
            NavigationController(
                rootViewController: DashboardViewController()
            ),
            animated: true,
            completion: nil
        )
    }
}
