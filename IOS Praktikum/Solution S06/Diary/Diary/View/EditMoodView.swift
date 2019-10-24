//
//  EditMoodView.swift
//  Diary
//
//  Created by Mehmet Baris Yaman on 13.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import SwiftUI
import CoreLocation

// MARK: - EditMood
struct EditMoodView: View {
    
    // MARK: Stored Instance Properties
    @EnvironmentObject private var model: Model
    @Environment(\.presentationMode) private var presentationMode
    
    @State var id: Mood.ID?
    @State private var description = ""
    @State private var date = Date()
    @State var classification: Mood.Classification = .neutral
    @State var textFormatter = TextFormatter()
    
    // MARK: Computed Instance Properties
    var body: some View {
        Form {
            Section(header: Text("Mood")) {
                HStack {
                    Picker("Moodiness", selection: $classification) {
                        ForEach(Mood.Classification.allCases) {
                            moodType in Text(moodType.rawValue).tag(moodType)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            Section(header: Text("Description")) {
                TextField("Description", value: $description, formatter: textFormatter)
            }
        }.onAppear(perform: updateStates).onDisappear(perform: saveAction)
    }
    
    private func saveAction() {
        for element in self.model.moods {
            if self.model.isToday(date: element.date) {
                self.model.delete(mood: element.id)
            }
        }
        let mood = Mood(id: self.id, description: self.description, date: Date(), point: self.classification.level)
        self.model.save(mood)
        self.updateStates()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private var deleteAlert: Alert {
        Alert(title: Text("Delete Mood"),
              message: Text("Are you sure you want to delete the mood?"),
              primaryButton: .destructive(Text("Delete"), action: {
                    self.delete()
              }),
              secondaryButton: .cancel())
    }
    
    // MARK: Instance Methods
    private func updateStates() {
        for element in self.model.moods {
            if self.model.isToday(date: element.date) {
                self.description = element.description
                self.classification = element.classification
            }
        }
    }
    
    private func delete() {
        id.map(model.delete(mood:))
        self.presentationMode.wrappedValue.dismiss()
    }
}

// MARK: - EditMoodPreviews
struct EditMoodView_Previews: PreviewProvider {
    static let model = Model.mock
    static var previews: some View {
        NavigationView {
            EditMoodView(id: model.moods[0].id, classification: model.moods[1].classification)
        }.environmentObject(model)
    }
}
