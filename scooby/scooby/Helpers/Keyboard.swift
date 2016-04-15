//
//  Keyboard.swift
//  scooby
//
//  Created by Lloyd Keijzer on 15-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import Foundation
import UIKit

@objc protocol KeyboardDelegate {
    optional func keyboardWillShow()
    optional func keyboardWillHide()
}

class Keyboard {
    
    static let sharedInstance = Keyboard()
    
    private var _isKeyboardActive: Bool = false
    private var _keyboardRect: CGRect?
    
    var delegate: KeyboardDelegate?
    
    private init() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let rectString: String? = defaults.objectForKey("keyboardRect") as! String?
        
        if (rectString != nil) {
            _keyboardRect = CGRectFromString(rectString!)
        } else {
            initiateKeyboard()
        }
    }
    
    private func initiateKeyboard() {
        let textField = UITextField()
        (UIApplication.sharedApplication().delegate as! AppDelegate).window?.addSubview(textField)
        textField.becomeFirstResponder()
        textField.resignFirstResponder()
        textField.removeFromSuperview()
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        _isKeyboardActive = true
        
        if delegate != nil {
            delegate?.keyboardWillShow?()
        }
        
        let info: NSDictionary = notification.userInfo!
        let aValue = info.objectForKey(UIKeyboardFrameEndUserInfoKey)
        _keyboardRect = aValue!.CGRectValue
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let rectString: String? = defaults.objectForKey("keyboardRect") as! String?
        
        if (rectString == nil || (rectString != nil && CGRectEqualToRect(CGRectFromString(rectString!), _keyboardRect!))) {
            defaults.setObject(NSStringFromCGRect(_keyboardRect!), forKey: "keyboardRect")
            defaults.synchronize()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        _isKeyboardActive = false
        
        if delegate != nil {
            delegate?.keyboardWillHide?()
        }
    }
    
    func isActive() -> Bool {
        return _isKeyboardActive
    }
    
    func rect() -> CGRect? {
        return _keyboardRect
    }
}