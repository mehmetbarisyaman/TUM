//
//  BackgroundModifier.swift
//  Diary
//
//  Created by Dominic Henze on 09.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import SwiftUI

struct BackgroundViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .background(Color("ListBackground"))
    }
}

extension View {
    func backgroundViewModifier() -> some View {
        ModifiedContent(content: self, modifier: BackgroundViewModifier())
    }
}
