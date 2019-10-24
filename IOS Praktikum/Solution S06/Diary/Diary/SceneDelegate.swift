//
//  SceneDelegate.swift
//  Diary
//
//  Created by Dominic Henze on 09.10.19.
//  Copyright © 2019 TUM LS1. All rights reserved.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        let contentView = MainView()
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView.environmentObject((Model(moods: Model.mock.moods)))
                .colorScheme(.dark))
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
