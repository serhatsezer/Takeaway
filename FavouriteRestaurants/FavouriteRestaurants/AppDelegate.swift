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
  private var appCoordinator: AppCoordinator? 

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    let window = UIWindow(frame: UIScreen.main.bounds)
    let appCoordinator = AppCoordinator(window: window)
    
    self.window = window
    self.appCoordinator = appCoordinator
    appCoordinator.start()
    
    return true
  }
  
}

