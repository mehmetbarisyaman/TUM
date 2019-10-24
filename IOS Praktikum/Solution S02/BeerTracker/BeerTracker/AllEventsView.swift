//
//  AllEventsView.swift
//  BeerTracker
//
//  Created by Mehmet Baris Yaman on 09.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import SwiftUI

struct AllEventsView: View {
    var body: some View {
        NavigationView {
            EventList().navigationBarTitle("BeerTracker")
        }
    }
}

struct AllEventsView_Previews: PreviewProvider {
    static var previews: some View {
        AllEventsView()
    }
}
