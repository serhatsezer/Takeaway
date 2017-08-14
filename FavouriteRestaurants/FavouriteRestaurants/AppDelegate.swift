//
//  AppDelegate.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 08/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        ThemeManager.appDefault()
        
        return true
    }

}

