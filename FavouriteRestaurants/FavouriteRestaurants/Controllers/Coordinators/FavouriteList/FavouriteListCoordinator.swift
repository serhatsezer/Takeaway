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
  
  fileprivate var detailCoordinator: RestaurantDetailCoordinator?
  
  init() {
  }
  
  func start() {
    let favouriteController = rootViewController.topViewController as! FavouriteListController
    favouriteController.delegate = self
  }
}

extension FavouriteListCoordinator: FavouriteListControllerDelegate {
  func favouriteRestaurantSelected(viewModel: RestaurantListViewModel) {
    detailCoordinator = RestaurantDetailCoordinator(presenter: rootViewController, viewModel: viewModel)
    detailCoordinator?.start()
  }
}
