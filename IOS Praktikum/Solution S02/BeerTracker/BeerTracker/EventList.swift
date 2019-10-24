//
//  EventList.swift
//  BeerTracker
//
//  Created by Mehmet Baris Yaman on 09.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import SwiftUI

struct EventList: View {
    var events: [BeerTracker]
    init() {
        let oktoberFest = BeerTracker(name: "Oktoberfest", location: "Munich", amountOfBeers: 4)
        let noReason = BeerTracker(name: "Drinking needs no reason", location: "Garching", amountOfBeers: 3)
        let bar = BeerTracker(name: "Bar", location: "Nürnberg", amountOfBeers: 3)
        events = [oktoberFest, noReason, bar]
    }
    
    var body: some View {
        List(events) {event in NavigationLink(destination:EventDetail(beerTracker: event)) {
            EventCell(beerTracker: event)}
        }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList()
    }
}
