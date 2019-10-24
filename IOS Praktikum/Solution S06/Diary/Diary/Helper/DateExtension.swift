//
//  DateExtension.swift
//  Diary
//
//  Created by Dominic Henze on 10.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import Foundation

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow: Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon) ?? Date()
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon) ?? Date()
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self) ?? Date()
    }
    
    func daysBefore(amount: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: -amount, to: noon) ?? Date()
    }
}
