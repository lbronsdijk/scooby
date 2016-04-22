//
//  Colors.swift
//  scooby
//
//  Created by Lloyd Keijzer on 11-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit

// define custom colors here (#rrggbbaa) alpha is optional
let COLOR_WHITE         = "#ffffff"
let COLOR_BLACK         = "#3d2c2a"
let COLOR_RED           = "#d84c3a"
let COLOR_GREEN         = "#6c9491"
let COLOR_LIGHTGRAY     = "#f0f0f0"
let COLOR_GRAY          = "#aea8a7"
let COLOR_LINEGRAY      = "#979797"

// extending UIColor to accept hex codes
extension UIColor {
    public convenience init?(hexString: String) {
        let r, g, b, a: CGFloat
        
        if hexString.hasPrefix("#") {
            let start = hexString.startIndex.advancedBy(1)
            var hexColor = hexString.substringFromIndex(start)
            
            if hexColor.characters.count == 6 {
                hexColor.appendContentsOf("ff")
            }
            
            if hexColor.characters.count == 8 {
                let scanner = NSScanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexLongLong(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
}