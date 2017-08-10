//
//  URLExtension.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 9/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import Foundation

extension URL {
    var queryDictionary:[String: [String]]? {
        get {
            if let query = self.query {
                var dictionary = [String: [String]]()
                
                for keyValueString in query.components(separatedBy: "&") {
                var parts = keyValueString.components(separatedBy: "=")
                    if parts.count < 2 { continue }
                    
                    let key = parts[0].removingPercentEncoding!
                    let value = parts[1].removingPercentEncoding!
                    
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
