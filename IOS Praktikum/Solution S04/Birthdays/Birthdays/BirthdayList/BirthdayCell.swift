//
//  BirthdayCell.swift
//  Birthdays
//
//  Created by Paul Schmiedmayer on 10/09/19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import SwiftUI

// MARK: - BirthdayCell
struct BirthdayCell: View {
        
    @EnvironmentObject var model: Model
    
    var id: Birthday.ID
    
    // MARK: Computed Instance Properties
    var body: some View {
        model.birthday(id).map() { birthday in
        VStack(alignment: .leading, spacing: 2) {
            HStack {
                Text(birthday.name)
                Spacer()
                Text(birthday.giftDone ? "🎁" : "🤷‍♂️")
            }.font(Font.system(size: 22, weight: .bold))
            Group {
                Text("Turning \(birthday.nextAge) on \(birthday.formattedDate)")
                Text(birthday.giftIdeas).foregroundColor(.secondary)
            }.font(Font.system(size: 14, weight: .regular))
        }.padding()
    }
    }
}

// MARK: - BirthdayCell_Previews
struct BirthdayCell_Previews: PreviewProvider {
    static let model = Model.mock
    
    static var previews: some View {
        ForEach(ColorScheme.allCases, id: \.hashValue) { colorScheme in
            BirthdayCell(id: model.birthdays[0].id)
                .colorScheme(colorScheme)
        }.environmentObject(Model.mock).background(Color("Background")).previewLayout(.sizeThatFits)
    }
}
