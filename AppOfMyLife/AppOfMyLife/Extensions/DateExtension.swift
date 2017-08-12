//
//  DateExtension.swift
//  AppOfMyLife
//
//  Created by Giovane Possebon on 10/8/17.
//  Copyright © 2017 giovane. All rights reserved.
//

import UIKit

extension Date {
    
    func traktApiFormatedData() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: self)
    }
    
    static func dateFromISOString(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        return dateFormatter.date(from: string)
    }
    
    func ISOStringFromDate(withDateFormatter dateFormatter: DateFormatter) -> String {
        return dateFormatter.string(from: self)
    }
    
    func ISODayAndMonthFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        return self.ISOStringFromDate(withDateFormatter: dateFormatter)
    }
    
    func ISOHourFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm"
        return self.ISOStringFromDate(withDateFormatter: dateFormatter)
    }
    
}
