//
//  MainView.swift
//  Diary
//
//  Created by Mehmet Baris Yaman on 13.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import SwiftUI

// MARK: - MainView
struct MainView: View {
    
    // MARK: Computed Instance Properties
    var body: some View {
        TabView {
            AllMoodsView().tabItem({
                Image(systemName: "book")
                Text("Diary")
            })
            EditMoodView(classification: Mood.Classification.neutral).tabItem({
                Image(systemName: "calendar.badge.plus")
                Text("Today")
            })
        }
    }
}

// MARK: - MainViewPreviews
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(Model.mock)
    }
}
