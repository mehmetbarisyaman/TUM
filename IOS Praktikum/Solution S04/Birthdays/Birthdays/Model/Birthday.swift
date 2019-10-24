//
//  Birthday.swift
//  Birthdays
//
//  Created by Paul Schmiedmayer on 10/09/19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import Foundation

// MARK: - Birthday
struct Birthday {
    
    // MARK: - Classification
    public enum Classification: String, CaseIterable, Identifiable {
        public var id: String {
            self.rawValue
        }
        
        public var bought: Bool {
            self == .bought
        }
        
        case bought = "Bought"
        case notBought = "Not Bought"
        
        public init(_ giftDone: Bool) {
            self = giftDone ? .bought : .notBought
        }
    }
    
    
    // MARK: Stored Instance Properties
    public var id: UUID
    public var date: Date
    public var name: String
    public var giftIdeas: String
    public var giftDone: Bool
    
    public var classification: Classification {
        Classification(giftDone)
    }
    
    public var nextAge: Int {
        let ageComponents = Calendar.current.dateComponents([.year], from: date, to: Date())
        guard let age = ageComponents.year else {
            return -1
        }
        return age + 1
    }
    
    public var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        return dateFormatter.string(from: date)
    }
    
    // MARK: Initializers
    public init(id: UUID? = nil, date: Date, name: String, giftIdeas: String? = nil, giftDone: Bool = false) {
        self.id = id ?? UUID()
        self.date = date
        self.name = name
        self.giftIdeas = giftIdeas ?? "No gift ideas yet"
        self.giftDone = giftDone
    }
    
    public init(id: UUID? = nil, year: Int, month: Int, day: Int, name: String, giftIdeas: String? = nil, giftDone: Bool = false) {
        self.id = id ?? UUID()
        self.date = Self.makeDate(year: year, month: month, day: day)
        self.name = name
        self.giftIdeas = giftIdeas ?? "No gift ideas yet"
        self.giftDone = giftDone
    }
}

extension Birthday {
    static func makeDate(year: Int, month: Int, day: Int) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = DateComponents(year: year, month: month, day: day)
        return calendar.date(from: components) ?? Date()
    }
}

// MARK: - Extension: Identifiable
extension Birthday: Identifiable { }

// MARK: - Extension: Equatable
extension Birthday: Equatable {
    public static func == (lhs: Birthday, rhs: Birthday) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Extension: Comparable
extension Birthday: Comparable {
    public static func < (lhs: Birthday, rhs: Birthday) -> Bool {
        let currentDate = lhs.date
        let previousDate = rhs.date
        let calendar = Calendar(identifier: .gregorian)
        let start = calendar.ordinality(of: .day, in: .year, for: Date())
        let prev = calendar.ordinality(of: .day, in: .year, for: currentDate)
        let current = calendar.ordinality(of: .day, in: .year, for: previousDate)
        let currentDiff = (current ?? 0) - (start ?? 0)
        let prevDiff = (prev ?? 0) - (start ?? 0)
        if currentDiff > 0 && prevDiff > 0 {
            return currentDiff > prevDiff ? true : false
        } else if currentDiff < 0 && prevDiff < 0 {
            return currentDiff > prevDiff ? true : false
        } else {
            return currentDiff < prevDiff ? true : false
        }
    }
}
