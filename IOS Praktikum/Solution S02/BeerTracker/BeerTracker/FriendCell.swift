//
//  FriendCell.swift
//  BeerTracker
//
//  Created by Mehmet Baris Yaman on 09.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import SwiftUI

struct FriendCell: View {
    var friend: Friend
    var body: some View {
        HStack(alignment: .center, spacing: 3) {
            if friend.isFavourite {
                Text("⭐")
            }
            Text(friend.firstName).font(Font.system(size:16, weight: .regular))
            Text(friend.lastName).font(Font.system(size:16, weight: .regular))
            Spacer()
            Text("\(friend.beerCount)").font(Font.system(size:16, weight: .bold)).foregroundColor(Color.green)
            Text("🍺").font(Font.system(size:16, weight: .regular))
        }
    }
}

struct FriendCell_Previews: PreviewProvider {
    static var previews: some View {
        FriendCell(friend:Friend(firstName: "Baris", lastName: "Yaman", beerCount: 3, isFavourite: true))
    }
}
