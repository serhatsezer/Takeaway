//
//  ApplicationCoordinator.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 21.08.2018.
//  Copyright © 2018 Serhat Sezer. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
  private let window: UIWindow
  private let restaurantListCoordinator: RestaurantListCoordinator
  private let favouriteRestaurantCoordinator: FavouriteListCoordinator
  
  let rootViewController: UITabBarController

  init(window: UIWindow) {
    self.window = window
    self.rootViewController = UITabBarController()
    
    self.restaurantListCoordinator = RestaurantListCoordinator()
    self.restaurantListCoordinator.start()
    
    self.favouriteRestaurantCoordinator = FavouriteListCoordinator()
    self.favouriteRestaurantCoordinator.start()
    
    self.rootViewController.viewControllers = [self.restaurantListCoordinator.rootViewController, self.favouriteRestaurantCoordinator.rootViewController]
  }
  
  func start() {
    window.rootViewController = rootViewController
    window.makeKeyAndVisible()
    ThemeManager.appDefault()
  }
}
