//
//  MoodCellView.swift
//  Diary
//
//  Created by Mehmet Baris Yaman on 13.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import SwiftUI

// MARK: - MoodCellView
struct MoodCellView: View {
    // MARK: Stored Instance Properties
    @EnvironmentObject var model: Model
    var id: Mood.ID
    
    // MARK: Computed Instance Properties
    var body: some View {
        model.mood(id).map() { mood in
            VStack(alignment: .leading, spacing: 4) {
                HStack(alignment: .top, spacing: 16) {
                    Text(getDayOfWeek(date: mood.date))
                        .font(Font.system(size: 22, weight: .bold)).foregroundColor(Color.white)
                    Spacer()
                    Text(mood.formattedDate).font(Font.system(size: 22, weight: .bold)).foregroundColor(Color.white)
                }
                HStack(alignment: .top, spacing: 16) {
                    Text(getFace(faceClass: mood.classification)).font(Font.system(size: 40, weight: .bold))
                    Text(mood.description)
                        .font(Font.system(size: 14, weight: .bold)).foregroundColor(Color.white)
                }
            }
        }
    }
    
    func getFace (faceClass: Mood.Classification) -> String {
        switch faceClass {
        case Mood.Classification.crying:
            return "😭"
        case Mood.Classification.sad:
            return "😞"
        case Mood.Classification.neutral:
            return "😐"
        case Mood.Classification.happy:
            return "🙂"
        case Mood.Classification.smiling:
            return "😄"
        }
    }
    
    func getDayOfWeek (date: Date) -> String {
        let calendar = Calendar.current
        let dayNum = calendar.component(.weekday, from: date)
        switch dayNum {
        case 1:
            return "Sunday"
        case 2:
            return "Monday"
        case 3:
            return "Tuesday"
        case 4:
            return "Wednesday"
        case 5:
            return "Thursday"
        case 6:
            return "Friday"
        case 7:
            return "Saturday"
        default:
            return "Week Day Error!"
        }
    }
}

// MARK: - TransactionCell_Previews
struct TransactionCell_Previews: PreviewProvider {
    static let model = Model.mock
    
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.hashValue) { colorScheme in
            MoodCellView(id: model.moods[0].id)
                .colorScheme(colorScheme)
        }.environmentObject(model)
                .background(Color("Background"))
                .previewLayout(.sizeThatFits)
    }
}
