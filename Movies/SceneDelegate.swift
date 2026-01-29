//
//  SceneDelegate.swift
//  Movies
//
//  Created by Gabriel Mendonça on 09/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.


import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: TabBarCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {return}
        let mainWindow = UIWindow(windowScene: windowScene)
        window = mainWindow
        coordinator = TabBarCoordinator(window: mainWindow)
        window?.makeKeyAndVisible()
        coordinator?.configTabBar()
        guard let _ = (scene as? UIWindowScene) else { return }
    }

}

