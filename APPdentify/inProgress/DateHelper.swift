//
//  DateHelper.swift
//  APPdentify
//
//  Created by Michael Castillo on 11/5/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import Foundation

struct DateHelper {
    
    static let dateFormatter = DateFormatter()
}

extension Date {
    
    var monthDayYearString: String {
        let date = DateHelper.dateFormatter.string(from: self)
                // TODO: - Add specific Date formatter to specific date
        return date
    }
    
}
