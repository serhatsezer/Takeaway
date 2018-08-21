//
//  RestaurantListDataSource.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 14/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import Foundation
import RealmSwift

struct RestaurantListDataSource {
  fileprivate var items = [RestaurantListViewModel]()
  
  init(items: [RestaurantListViewModel]) {
    self.items = items
  }
  
  /// Returns restaurant list data source information
  var count: Int {
    return self.items.count
  }
  
  /// Returns restaurant view model for to use tableview cell
  ///
  /// - Parameter indexPath: Given table view index path
  /// - Returns: Restaurant view model from given data source.
  func item(at indexPath: IndexPath) -> RestaurantListViewModel {
    return self.items[indexPath.row]
  }
  
  /// Returns all restaurant and set all restaurant if there will be any filtiring request
  var restaurants:[RestaurantListViewModel] {
    get {
      return self.items
    }
    set {
      self.items = newValue
    }
  }
}
