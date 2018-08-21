//
//  FavouriteListCoordinator.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 21.08.2018.
//  Copyright © 2018 Serhat Sezer. All rights reserved.
//

import UIKit

class FavouriteListCoordinator: Coordinator {
  public var rootViewController: UINavigationController = {
    let storyboard = UIStoryboard(name: "FavoruiteList", bundle: nil).instantiateViewController(withIdentifier: "FavouriteListNavigationIdentifier") as! UINavigationController
    return storyboard
  }()
  
  init() {
  }
  
  func start() {
  }
}
