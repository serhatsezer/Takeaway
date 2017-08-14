//
//  ThemeManager.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 09/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import UIKit

struct ThemeManager {
    static func appDefault() {
        
        // Navigation
        let navAppearance = UINavigationBar.appearance()
        navAppearance.barTintColor = UIColor.appDefault
        navAppearance.tintColor = UIColor.white
        navAppearance.backgroundColor = UIColor.appDefault
        navAppearance.isTranslucent = false
        
//        let uiBarButton = UIBarButtonItem.appearance()
//        uiBarButton.setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), for: .default)
        
        // UITabbar
        UITabBar.appearance().barTintColor = .tabColor
        UITabBar.appearance().tintColor = .white
    }
}
