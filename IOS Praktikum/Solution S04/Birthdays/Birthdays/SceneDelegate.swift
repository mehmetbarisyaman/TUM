//
//  SceneDelegate.swift
//  Birthdays
//
//  Created by Paul Schmiedmayer on 10/09/19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let contentView = AllBirthdaysView()

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView.environmentObject(Model(birthdays: Model.mock.birthdays)))
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
