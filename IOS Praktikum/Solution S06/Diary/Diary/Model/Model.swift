//
//  Model.swift
//  Diary
//
//  Created by Mehmet Baris Yaman on 13.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import Foundation
import Combine

// MARK: - Model
public class Model {
    
    // MARK: Stored Instance Properties
     @Published public private(set) var moods: [Mood] {
         didSet {
             moods.saveToFile()
         }
     }
    
    // MARK: Initializer
    public init(moods: [Mood]? = nil) {
        self.moods = moods ?? Mood.loadFromFile()
    }
    
    // MARK: Instance Methods
    public func mood(_ id: Mood.ID?) -> Mood? {
        moods.first(where: { $0.id == id })
    }
    
    public func save(_ mood: Mood) {
        delete(mood: mood.id)
        moods.append(mood)
        print(moods)
        moods.sort()
    }
    
    public func delete(mood id: Mood.ID) {
        moods.removeAll(where: { $0.id == id })
    }
    
    // MARK: Private Type Methods
    private static func date(minutesFromNow minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: Date()) ?? Date()
    }
    
    func isToday (date: Date) -> Bool {
        let calendar = Calendar.current
        let day1 = calendar.component(.day, from: date)
        let day2 = calendar.component(.day, from: Date())
        return day1 == day2 ? true : false
    }
}

// MARK: Extension: Model: ObservableObject
extension Model: ObservableObject { }

// MARK: Extension: Model
#if DEBUG
extension Model {
    
    // MARK: Stored Type Properties
    public static var mock: Model {
        
        let day1 = Mood(description: "Did App4 Hw", date: (date(minutesFromNow: -8000)), point: 3)
        let day2 = Mood(description: "Played Basketball", date: (date(minutesFromNow: -10000)), point: 1)
        let day3 = Mood(description: "Did Nothing", date: (date(minutesFromNow: -12000)), point: 2)
        let day4 = Mood(description: "Did App2 HW", date: (date(minutesFromNow: -14000)), point: 4)
        let day5 = Mood(description: "Did Swift1 HW", date: (date(minutesFromNow: -16000)), point: 0)
        
        let mock = Model(moods: [day1, day2, day3, day4, day5])
        
        mock.moods.sort()
        
        return mock
    }
}
#endif
