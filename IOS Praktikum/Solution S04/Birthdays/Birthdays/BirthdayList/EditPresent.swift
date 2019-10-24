//
//  EditPresent.swift
//  Birthdays
//
//  Created by Mehmet Baris Yaman on 11.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import SwiftUI

struct EditPresent: View {
    @Binding var giftIdeas: String
    @Binding var classification: Birthday.Classification
    
    
    var body: some View {
        Section(header: Text("Gift Ideas")) {
            HStack {
                HStack(alignment: .center) {
                    Text("\(classification.sign)")
                    TextField("Gift Ideas", value: $giftIdeas)
                }
                Picker("Gift Idea", selection: $classification) {
                    ForEach(Birthday.Classification.allCases) {
                        giftType in Text(giftType.rawValue).tag(giftType)
                    }
                }.pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}

struct EditPresent_Previews: PreviewProvider {

    @State static var amount: Double = 120
    @State static var classification = Birthday.Classification.taken
    
    static var previews: some View {
        Form {
            EditPresent(giftIdeas: $giftIdeas, classification: $classification)
        }
    }
}
