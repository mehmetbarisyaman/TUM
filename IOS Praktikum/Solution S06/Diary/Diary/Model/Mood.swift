//
//  Mood.swift
//  Diary
//
//  Created by Mehmet Baris Yaman on 13.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import Foundation
import CoreLocation

// MARK: - Transaction
public struct Mood {
    
    // MARK: Classification
    public enum Classification: String, CaseIterable, Identifiable {
        // MARK: Stored Instance Properties
        public var id: String {
            self.rawValue
        }
        
        public var level: Int {
            switch self {
            case .crying:
                return 0
            case .sad:
                return 1
            case .neutral:
                return 2
            case .happy:
                return 3
            case .smiling:
                return 4
            }
        }
        
        case smiling = "😄"
        case happy = "🙂"
        case neutral = "😐"
        case sad = "😞"
        case crying = "😭"
        
        // MARK: Initializers
        public init(_ point: Int) {
            switch point {
            case 0:
                self = .crying
            case 1:
                self = .sad
            case 3:
                self = .happy
            case 4:
                self = .smiling
            default:
                self = .neutral
            }
        }
    }
    
    // MARK: Stored Instance Properties
    public var id: UUID
    public var description: String
    public var date: Date
    public var point: Int
    
    public var classification: Classification {
        Classification(point)
    }
    
    // MARK: Initializers
    public init(id: UUID? = nil, description: String, date: Date? = nil, point: Int = 5) {
        self.id = id ?? UUID()
        self.point = point
        self.description = description
        self.date = date ?? Date()
    }
    
    public var formattedDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        return dateFormatter.string(from: date)
    }
}

// MARK: - Extension: Identifiable
extension Mood: Identifiable { }


// MARK: - Extension: Comparable
extension Mood: Comparable {
    public static func < (lhs: Mood, rhs: Mood) -> Bool {
        return lhs.date > rhs.date
    }
}

// MARK: - Extension: Hashable
extension Mood: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

// MARK: - Extension: LocalFileStorable
extension Mood: LocalFileStorable {
    static var fileName = "Moods"
}
