//
//  AllMoodsView.swift
//  Diary
//
//  Created by Mehmet Baris Yaman on 13.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import SwiftUI

// MARK: - AllMoodsView
struct AllMoodsView: View {
    
    // MARK: Stored Instance Properties
    @EnvironmentObject private var model: Model
    
    // MARK: Computed Instance Properties
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                List(model.moods) { mood in
                    MoodCellView(id: mood.id).cardButtonViewModifier(color: self.cardColor(currentMood: mood)).padding(8)
                }
            }
        }
    }
    
    func cardColor(currentMood: Mood) -> Color {
        switch currentMood.classification {
        case .crying:
            return Color.purple
        case .sad:
            return Color.blue
        case .neutral:
            return Color.yellow
        case .happy:
            return Color.orange
        case .smiling:
            return Color.green
        }
    }
}

struct AllMoodsView_Previews: PreviewProvider {
    static var previews: some View {
        AllMoodsView()
    }
}
