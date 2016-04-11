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
let COLOR_BLACK         = "#000000"
let COLOR_RED           = "#ff4845"
let COLOR_GREEN         = "#48caaa"
let COLOR_BLUE          = "#487dca"
let COLOR_DARKGRAY      = "#1d242a"
let COLOR_LIGHTGRAY     = "#838a90"
let COLOR_SPOTIFYGREEN  = "#2ebd59"
let COLOR_ITUNESBLUE    = "#4e8df2"

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