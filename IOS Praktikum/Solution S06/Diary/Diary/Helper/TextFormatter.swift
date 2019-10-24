//
//  TextFormatter.swift
//  Diary
//
//  Created by Dominic Henze on 10.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import Foundation

class TextFormatter: Formatter {
    
    public var textLength: Int = 50
    
    override func string(for obj: Any?) -> String? {
        if let text = obj as? String {
            return String(text.prefix(textLength))
        }
        return nil
    }
    
    override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?,
                                 for string: String,
                                 errorDescription error: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        if let objok = obj {
            objok.pointee = string as AnyObject?
            return true
        }

        return false
    }
}
