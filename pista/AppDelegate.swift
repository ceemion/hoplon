//
//  AppDelegate.swift
//  hoplon
//
//  Created by Fiyinfoluwa Adebayo on 24/11/2019.
//  Copyright © 2019 Kompilab Limited. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        // See all fonts on app
        //for family in UIFont.familyNames.sorted() {
        //    let names = UIFont.fontNames(forFamilyName: family)
        //    print("Family: \(family) Font names: \(names)")
        //}

        guard UIFont(name: "NewYorkSmall-Regular", size: UIFont.labelFontSize) != nil else {
            fatalError("""
        Failed to load the "NewYorkSmall-Regular" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """)
        }

        guard UIFont(name: "Freshca-Regular", size: UIFont.labelFontSize) != nil else {
            fatalError("""
        Failed to load the "Freshca-Regular" font.
        Make sure the font file is included in the project and the font name is spelled correctly.
        """)
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

