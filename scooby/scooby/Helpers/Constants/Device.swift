//
//  Device.swift
//  scooby
//
//  Created by Lloyd Keijzer on 11-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import UIKit

// extending UIDevice to recognize device models and iOS version
public extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8 where value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
    public func isDevice(deviceName: String) -> Bool {
        return (deviceName == modelName)
    }
    
    public func isSystemVersionEqualTo(version: String) -> Bool {
        return ((UIDevice.currentDevice().systemVersion.compare(version, options: .NumericSearch)) == .OrderedSame)
    }
    public func isSystemVersionGreaterThan(version: String) -> Bool {
        return ((UIDevice.currentDevice().systemVersion.compare(version, options: .NumericSearch)) == .OrderedDescending)
    }
    public func isSystemVersionGreaterThanOrEqualTo(version: String) -> Bool {
        return ((UIDevice.currentDevice().systemVersion.compare(version, options: .NumericSearch)) != .OrderedAscending)
    }
    public func isSystemVersionLessThan(version: String) -> Bool {
        return ((UIDevice.currentDevice().systemVersion.compare(version, options: .NumericSearch)) == .OrderedAscending)
    }
    public func isSystemVersionLessThanOrEqualTo(version: String) -> Bool {
        return ((UIDevice.currentDevice().systemVersion.compare(version, options: .NumericSearch)) != .OrderedDescending)
    }
}

// iphone booleans
let IS_IPHONE = UIDevice.currentDevice().isDevice("iPhone 4") || UIDevice.currentDevice().isDevice("iPhone 4s") || UIDevice.currentDevice().isDevice("iPhone 5") || UIDevice.currentDevice().isDevice("iPhone 5c") || UIDevice.currentDevice().isDevice("iPhone 5s") || UIDevice.currentDevice().isDevice("iPhone 6") || UIDevice.currentDevice().isDevice("iPhone 6 Plus") || UIDevice.currentDevice().isDevice("iPhone 6s") || UIDevice.currentDevice().isDevice("iPhone 6s Plus")
let IS_IPHONE4 = UIDevice.currentDevice().isDevice("iPhone 4") || UIDevice.currentDevice().isDevice("iPhone 4s")
let IS_IPHONE5 = UIDevice.currentDevice().isDevice("iPhone 5") || UIDevice.currentDevice().isDevice("iPhone 5s") || UIDevice.currentDevice().isDevice("iPhone 5c")
let IS_IPHONE6 = UIDevice.currentDevice().isDevice("iPhone 6")
let IS_IPHONE6Plus = UIDevice.currentDevice().isDevice("iPhone 6 Plus")
let IS_IPHONE6S = UIDevice.currentDevice().isDevice("iPhone 6s")
let IS_IPHONE6SPlus = UIDevice.currentDevice().isDevice("iPhone 6s Plus")

// ipad booleans
let IS_IPAD = UIDevice.currentDevice().isDevice("iPad 2") || UIDevice.currentDevice().isDevice("iPad 3") || UIDevice.currentDevice().isDevice("iPad 4") || UIDevice.currentDevice().isDevice("iPad Air") || UIDevice.currentDevice().isDevice("iPad Air 2") || UIDevice.currentDevice().isDevice("iPad Mini") || UIDevice.currentDevice().isDevice("iPad Mini 2") || UIDevice.currentDevice().isDevice("iPad Mini 3") || UIDevice.currentDevice().isDevice("iPad Mini 4") || UIDevice.currentDevice().isDevice("iPad Pro")
