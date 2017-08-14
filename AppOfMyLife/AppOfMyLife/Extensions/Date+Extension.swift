//
//  DateExtension.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 10/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

enum DateFormat: String {
    case dayAndMonth = "dd/MM"
    case dayMonthAndHour = "dd/MM - HH:mm"
    case hour = "HH:mm"
    case year = "YYYY"
    case traktAPI = "yyyy-MM-dd"
}

extension Date {
    
    static func dateFromISOString(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter.date(from: string)
    }
    
    func ISOStringFromDate(withDateFormat format: DateFormat) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
    
}
