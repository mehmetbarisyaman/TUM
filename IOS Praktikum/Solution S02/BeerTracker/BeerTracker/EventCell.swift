//
//  EventCell.swift
//  BeerTracker
//
//  Created by Mehmet Baris Yaman on 09.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import SwiftUI

struct EventCell: View {
    var beerTracker: BeerTracker
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(alignment: .top, spacing: 16) {
                Text(beerTracker.nameDescription).font(Font.system(size:22, weight: .bold))
                Spacer()
                Text("\(beerTracker.amountOfBeers) 🍺").font(Font.system(size: 16, weight: .bold)).foregroundColor(Color.green)
              }
            HStack(alignment: .bottom, spacing: 4) {
                Text(beerTracker.locationDescription).font(Font.system(size:12, weight: .regular))
                Text(beerTracker.dateDescription).font(Font.system(size:12, weight: .regular))
            }
        }
    }
}

struct EventCell_Previews: PreviewProvider {
    static var previews: some View {
        EventCell(beerTracker: BeerTracker(name: "OktoberFest", location: "Munich", amountOfBeers: 4))
    }
}
