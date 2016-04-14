//
//  QueryDictionary.swift
//  scooby
//
//  Created by Lloyd Keijzer on 13-04-16.
//  Copyright © 2016 Lloyd Keijzer. All rights reserved.
//

import Foundation

extension NSURL
{
    @objc var queryDictionary:[String: [String]]? {
        get {
            if let query = self.query {
                var dictionary = [String: [String]]()
                
                for keyValueString in query.componentsSeparatedByString("&") {
                    var parts = keyValueString.componentsSeparatedByString("=")
                    if parts.count < 2 { continue; }
                    
                    let key = parts[0].stringByRemovingPercentEncoding!
                    let value = parts[1].stringByRemovingPercentEncoding!
                    
                    var values = dictionary[key] ?? [String]()
                    values.append(value)
                    dictionary[key] = values
                }
                
                return dictionary
            }
            
            return nil
        }
    }
}