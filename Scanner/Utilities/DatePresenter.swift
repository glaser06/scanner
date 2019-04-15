//
//  DatePresenter.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/14/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import Foundation

class DatePresenter {
    
    static func fullDateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        
        formatter.amSymbol = "am"
        formatter.pmSymbol = "pm"
        
        
        
        
        formatter.dateFormat = "MMM dd, YYYY hh:mm a"
        
        
        let dateString = formatter.string(from: date)
        return dateString
    }
    
}
