//
//  RestaurantDetailCoordinator.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 21.08.2018.
//  Copyright © 2018 Serhat Sezer. All rights reserved.
//

import UIKit

class RestaurantDetailCoordinator: Coordinator {
  fileprivate var presenter: UINavigationController
  fileprivate var viewModel: RestaurantListViewModel
  
  public var detailController: RestaurantDetailController = {
    let navigationController = UIStoryboard(name: "RestaurantDetail", bundle: nil).instantiateViewController(withIdentifier: "RestaurantDetailNavigationIdentifier") as! UINavigationController
    let detailController = navigationController.topViewController as! RestaurantDetailController
    return detailController
  }()
  
  init(presenter: UINavigationController, viewModel: RestaurantListViewModel) {
    self.presenter = presenter
    self.viewModel = viewModel
  }
  
  func start() {
    // I use property injection because of storyboard
    detailController.restaurantViewModel = self.viewModel
    self.presenter.pushViewController(detailController, animated: true)
  }
  
}
