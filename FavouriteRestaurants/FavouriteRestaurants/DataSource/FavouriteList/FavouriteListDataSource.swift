//
//  FavouriteListDataSource.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 17/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import Foundation
import RealmSwift

protocol FavouriteListDataSourceRepresantable {
  
  /// Fetchs item from Realm database
  ///
  /// - Parameter indexPath: Given IndexPath value from table view
  /// - Returns: Returns optional view model if requested item already exist in database
  func fetchItem(indexPath: IndexPath) -> RestaurantListViewModel?
  
  /// Returns total count of favourite item
  var count: Int { get }
}

class FavouriteListDataSource: FavouriteListDataSourceRepresantable {
  
  func fetchItem(indexPath: IndexPath) -> RestaurantListViewModel? {
    let fetchedAllItems = PersistenceHelper.fetchAllItems()
    guard indexPath.row < fetchedAllItems.count else {
      return nil
    }
    let restaurantItemModel = fetchedAllItems[indexPath.row]
    let viewModel = RestaurantListViewModel(model: restaurantItemModel)
    return viewModel
  }
  
  var count: Int {
    return PersistenceHelper.fetchAllItems().count
  }
}



