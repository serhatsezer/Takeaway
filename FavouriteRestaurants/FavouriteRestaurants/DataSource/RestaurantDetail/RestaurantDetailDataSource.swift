//
//  RestaurantDetailDataSource.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 18/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import Foundation

struct RestaurantDetailDataSource {
  fileprivate var items: [String]!
  fileprivate var sections: [String]!
  
  init(items: [String], sections: [String]) {
    self.items = items
    self.sections = sections
  }
  
  /// Returns product list data source information
  var count: Int {
    return self.items.count
  }
  
  /// Returns section count
  var sectionCount: Int {
    return self.sections.count
  }
  
  /// Returns dummy product list string for to use tableview cell
  ///
  /// - Parameter indexPath: Given table view index path
  /// - Returns: dummy string from given data source.
  func product(at indexPath: IndexPath) -> String {
    return self.items[indexPath.row]
  }
  
  func section(index: Int) -> String {
    return sections[index].uppercased()
  }
  
  /// Returns all products and set all restaurant if there will be any filtiring request
  var products: [String] {
    get {
      return self.items
    }
    set {
      self.items = newValue
    }
  }
}
