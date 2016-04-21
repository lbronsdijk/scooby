//
//  NSCoderEmpty.swift
//  scooby
//
//  Created by Lloyd Keijzer on 21-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import Foundation

extension NSCoder {
    class func empty() -> NSCoder {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.finishEncoding()
        return NSKeyedUnarchiver(forReadingWithData: data)
    }
}