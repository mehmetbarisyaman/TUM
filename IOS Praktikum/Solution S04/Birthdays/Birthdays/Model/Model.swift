//
//  Model.swift
//  Birthdays
//
//  Created by Mehmet Baris Yaman on 10.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import Foundation
import Combine

public class Model {
    
    // MARK: Stored Instance Properties
    @Published private(set) var birthdays: [Birthday]
    
    // MARK: Initializer
    init(birthdays: [Birthday]) {
        self.birthdays = birthdays
    }
    
    // MARK: Instance Methods
    func birthday(_ id: Birthday.ID?) -> Birthday? {
        for birthday in birthdays where birthday.id == id {
            return birthday
        }
        return nil
    }
    
    func delete(birthday id: Birthday.ID) {
        guard let birthday = birthday(id), let index = birthdays.firstIndex(of: birthday) else {
            return
        }
        birthdays.remove(at: index)
    }
    
    func save(_ birthday: Birthday) {
        delete(birthday: birthday.id)
        birthdays.append(birthday)
        birthdays = birthdays.sorted(by: <)
    }
}

// MARK: Extension: Model: ObservableObject
extension Model: ObservableObject {}

// MARK: Extension: Model
#if DEBUG

extension Model {
    
    // MARK: Stored Type Properties
    public static var mock: Model {
        let mock = Model(birthdays: [
            Birthday(year: 1990, month: 1, day: 11, name: "Dora Dzvonyar", giftIdeas: "A unicorn that sparkles"),
            Birthday(year: 1995, month: 12, day: 29, name: "Paul Schmiedmayer", giftIdeas: "A big hug", giftDone: true),
            Birthday(year: 1991, month: 2, day: 18, name: "Dominic Henze", giftIdeas: "Ice ceam, lots of ice cream", giftDone: true),
            Birthday(year: 1996, month: 10, day: 10, name: "Florian Bodlée"),
            Birthday(year: 1963, month: 08, day: 24, name: "Mustafa Yaman", giftIdeas: "A big hug", giftDone: false),
            Birthday(year: 1961, month: 03, day: 17, name: "Gulser Yaman", giftDone: false),
            Birthday(year: 1994, month: 06, day: 25, name: "Baris Yaman", giftIdeas: "An iphone X", giftDone: true),
            Birthday(year: 1999, month: 02, day: 13, name: "Burak Yaman", giftDone: false),
            Birthday(year: 1987, month: 11, day: 30, name: "Mehmet Yaman", giftDone: true),
            Birthday(year: 1973, month: 05, day: 10, name: "Mucahit Yaman", giftDone: false)
        ])
        
        mock.birthdays = mock.birthdays.sorted(by: <)
        
        return mock
    }
    
    // MARK: Private Type Methods
    private static func date(minutesFromNow minutes: Int) -> Date {
        return Calendar.current.date(byAdding: .minute, value: minutes, to: Date()) ?? Date()
    }
}

#endif
