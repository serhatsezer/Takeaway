//
//  RestaurantListCoordinator.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 21.08.2018.
//  Copyright © 2018 Serhat Sezer. All rights reserved.
//

import UIKit

class RestaurantListCoordinator: Coordinator {
  public var rootViewController: UINavigationController = {
    let sb = UIStoryboard(name: "RestaurantList", bundle: nil).instantiateViewController(withIdentifier: "RestaurantListNavigationIdentifier") as! UINavigationController
    return sb
  }()
  
  fileprivate var restaurantDetailCoordinator: RestaurantDetailCoordinator?
  
  init() {
  }
  
  func start() {
    let restaurantListController = rootViewController.topViewController as! RestaurantListController
    restaurantListController.delegate = self
  }
}

extension RestaurantListCoordinator: RestaurantListControllerDelegate {
  func restaurantItemSelected(viewModel: RestaurantListViewModel) {
    print("detail did tapped! \(viewModel)")
    self.restaurantDetailCoordinator = RestaurantDetailCoordinator(presenter: rootViewController, viewModel: viewModel)
    self.restaurantDetailCoordinator?.start()
  }
}
