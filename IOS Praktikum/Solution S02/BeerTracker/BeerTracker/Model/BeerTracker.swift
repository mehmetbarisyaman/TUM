//
//  BeerTracker.swift
//  BeerTracker
//
//  Created by Mehmet Baris Yaman on 08.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import Foundation

struct BeerTracker: Identifiable {
    var id: UUID
    var name: String
    var location: String
    var date: Date
    var amountOfBeers: Int
    var friends: [Friend]
    
    public init(id: UUID? = nil, name: String, location: String, date: Date? = nil, amountOfBeers: Int, friends: [Friend]? = nil) {
        let mehmet = Friend(firstName: "Mehmet", lastName: "Yaman", beerCount: 3, isFavourite: false)
        let baris = Friend(firstName: "Baris", lastName: "Yaman", beerCount: 2, isFavourite: true)
        let yamanFriends = [mehmet, baris]
        self.id = id ?? UUID()
        self.name = name
        self.location = location
        self.date = date ?? Date()
        self.amountOfBeers = amountOfBeers
        self.friends = friends ?? yamanFriends
    }
    
    public var locationDescription: String {
        return location
    }
    
    public var dateDescription: String {
        return DateFormatter.onlyDate.string(from: date)
    }
    
    public var nameDescription: String {
        return name
    }
    
    public var findAmountOfBeers: Int {
        return amountOfBeers
    }
}
