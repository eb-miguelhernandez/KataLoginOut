//
//  AppDelegate.swift
//  KataLoginOut
//
//  Created by Miguel Hernández Jaso on 24/01/2019.
//  Copyright © 2019 Miguel Hernández Jaso. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let vc = LoginVC()

        window = UIWindow(frame: UIScreen.main.bounds)

        window?.rootViewController = vc
        window?.makeKeyAndVisible()

        return true
    }
}

