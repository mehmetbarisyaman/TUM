//
//  AllBirthdaysView.swift
//  Birthdays
//
//  Created by Mehmet Baris Yaman on 10.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import SwiftUI

// MARK: - AllBirthdaysView
struct AllBirthdaysView: View {
    
    // MARK: Stored Instance Properties
    @EnvironmentObject private var model: Model
    
    @State var presentAddBirthday = false
    
    private var birthdays: [Birthdays.Birthday] {
        model.birthdays
    }
    
    // MARK: Computed Instance Properties
    var body: some View {
        
        NavigationView {
            List(birthdays) { birthday in NavigationLink (destination: EditBirthday(id: birthday.id)) {
                    BirthdayCell(id: birthday.id)
            }
            }.navigationBarTitle(Text("Birthdays"), displayMode: .large)
                .navigationBarItems(trailing: self.addButton).sheet(isPresented: self.$presentAddBirthday) {
            NavigationView {
                EditBirthday()
            }.environmentObject(self.model)
            }
        }
    }
    
    // MARK: Private Computed Instance Properties
    private var addButton: some View {
        
        Button(action: { self.presentAddBirthday = true }) {
            //Image(systemName: "Plus")
            Text("+").font(Font.system(size:20, weight: .bold))
        }
    }
}

// MARK: - AllBirthdaysView_Previews
struct AllBirthdaysView_Previews: PreviewProvider {
    static var previews: some View {
        AllBirthdaysView()
    }
}
