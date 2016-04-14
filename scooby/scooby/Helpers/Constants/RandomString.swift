//
//  RandomString.swift
//  scooby
//
//  Created by Lloyd Keijzer on 13-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import Foundation

extension String {
    
    static func random(length: Int = 20) -> String {
        
        let base = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var randomString: String = ""
        
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.characters.count))
            randomString += "\(base[base.startIndex.advancedBy(Int(randomValue))])"
        }
        
        return randomString
    }
}