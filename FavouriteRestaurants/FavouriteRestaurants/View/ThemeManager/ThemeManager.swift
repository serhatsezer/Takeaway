//
//  ThemeManager.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 09/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import UIKit

struct ThemeManager {
  
  /// Basically changes all application ui
  /// We can also add fonts or other neccessary stuff
  static func appDefault() {
    // Navigation
    let navAppearance = UINavigationBar.appearance()
    navAppearance.barTintColor = UIColor.appDefault
    navAppearance.tintColor = UIColor.white
    navAppearance.backgroundColor = UIColor.appDefault
    navAppearance.isTranslucent = false
    navAppearance.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    
    // UITabbar
    UITabBar.appearance().barTintColor = .tabColor
    UITabBar.appearance().tintColor = .white
    
    // Segmented control
    UISegmentedControl.appearance().tintColor = UIColor.appDefault
  }
}
