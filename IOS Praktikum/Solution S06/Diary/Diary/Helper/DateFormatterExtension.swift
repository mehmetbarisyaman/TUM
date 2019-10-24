//
//  DateFormatterExtension.swift
//  Diary
//
//  Created by Dominic Henze on 09.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import Foundation

extension DateFormatter {
    public static let onlyDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = .short
        return dateFormatter
    }()
    
    public static let onlyDay: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter
    }()
}
