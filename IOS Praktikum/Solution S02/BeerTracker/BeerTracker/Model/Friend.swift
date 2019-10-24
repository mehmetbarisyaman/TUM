//
//  Friend.swift
//  BeerTracker
//
//  Created by Mehmet Baris Yaman on 08.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import Foundation

struct Friend: Identifiable {
    var id: UUID
    var firstName: String
    var lastName: String
    var beerCount: Int
    var isFavourite: Bool
    
    public init(id: UUID? = nil, firstName: String, lastName: String, beerCount: Int, isFavourite: Bool) {
        self.id = id ?? UUID()
        self.firstName = firstName
        self.lastName = lastName
        self.beerCount = beerCount
        self.isFavourite = isFavourite
    }
}
