//
//  EventDetail.swift
//  BeerTracker
//
//  Created by Mehmet Baris Yaman on 09.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import SwiftUI

struct EventDetail: View {
    var beerTracker: BeerTracker
    var friends: [Friend]
    init(beerTracker: BeerTracker) {
        let barisYaman = Friend(firstName: "Baris", lastName: "Yaman", beerCount: 3, isFavourite: true)
        let mehmetYaman = Friend(firstName: "Mehmet", lastName: "Yaman", beerCount: 4, isFavourite: false)
        friends = [barisYaman, mehmetYaman]
        self.beerTracker = beerTracker
    }
    var body: some View {
        HStack(alignment: .top, spacing: 2) {
            VStack (alignment: .center, spacing: 4) {
                Text(beerTracker.name).font(Font.system(size:22, weight: .bold))
                Text("On \(beerTracker.dateDescription) you went drinking with the following friends: ")
                List {ForEach(friends) { friend in
                    FriendCell(friend: Friend(firstName: friend.firstName,
                                              lastName: friend.lastName,
                                              beerCount: friend.beerCount,
                                              isFavourite: friend.isFavourite))
                }
                }}
        }
    }
}

struct EventDetail_Previews: PreviewProvider {
    static var previews: some View {
        EventDetail(beerTracker: BeerTracker(name: "OktoberFest", location: "Munich", amountOfBeers: 3))
    }
}
