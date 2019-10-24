//
//  EditBirthday.swift
//  Birthdays
//
//  Created by Mehmet Baris Yaman on 10.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import SwiftUI

struct EditBirthday: View {
    
    // MARK: Stored Instance Properties
    @EnvironmentObject private var model: Model
    
    @Environment(\.presentationMode) private var presentationMode
    
    @State var id: Birthday.ID?
    @State private var name: String = ""
    @State private var date = Date()
    @State private var giftIdeas: String = ""
    @State private var classification: Birthday.Classification = .notBought
    
    // MARK: Computed Instance Properties
    var body: some View {
        Form {
            Section(header: Text("Name")) {
                TextField("Name", text: $name)
            }
            Section(header: Text("Gift Ideas")) {
                HStack {
                    TextField("Gift Ideas", text: $giftIdeas)
                    Picker("Gift Bought?", selection: $classification) {
                        ForEach(Birthday.Classification.allCases) {
                            giftType in Text(giftType.rawValue).tag(giftType)
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
            }
            Section(header: Text("Date")) {
                DatePicker(selection: $date, in: ...Date(), displayedComponents: [.date]) {
                    Text("Date")
                }
            }
            if checkRowID() {
                Section(header: Text("Remove")) {
                    Button(action: remove) {
                        Text("Remove").bold()
                    }
                }
            }
        }.onAppear(perform: updateStates)
            .navigationBarTitle(id == nil ? "Add Birthday" : "Edit Birthday", displayMode: .inline).navigationBarItems(trailing: addButton)
    }
    
    private var addButton: some View {
        Button(action: save) {
            Text("Done").bold()
        }.disabled(name.isEmpty)
    }
    
    // MARK: Private Instance Methods
    private func updateStates() {
        guard let birthday = model.birthday(id) else {
            self.name = ""
            self.date = Date()
            self.classification = Birthday.Classification.notBought
            self.giftIdeas = "No Ideas yet "
            return
        }
        self.name = birthday.name
        self.date = birthday.date
        self.classification = birthday.classification
        self.giftIdeas = birthday.giftIdeas
    }
    
    private func checkRowID() -> Bool {
        if id != nil {
            return true
        }
        return false
    }
    
    private func save() {
        let birthday = Birthday(id: self.id, date: self.date, name: self.name, giftIdeas: self.giftIdeas, giftDone: self.classification.bought)
        self.model.save(birthday)
        updateStates()
        self.presentationMode.wrappedValue.dismiss()
    }
    
    private func remove() {
        guard let id = id  else {
            return
        }
        self.model.delete(birthday: id)
        self.presentationMode.wrappedValue.dismiss()
    }
}

// MARK: EditBirthday_Previews
struct EditBirthday_Previews: PreviewProvider {
    static let model = Model.mock
    static var previews: some View {
        NavigationView {
            EditBirthday(id: model.birthdays[0].id).navigationBarTitle("Birthday Editor")
        }.environmentObject(model)
    }
}
