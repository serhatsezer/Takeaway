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
  
  /// Writes restaurant item in Realm database
  ///
  /// - Parameter model: Holds all restaurant information
  func write(model: RestaurantListViewModel, completion: () -> Void)
  
  /// Retuns all Favourite item
  ///
  /// - Returns: Returns list of favourite item
  func fetchAllItems() -> [RestaurantItem]
}

struct FavouriteListDataSource: FavouriteListDataSourceRepresantable {
  fileprivate var realm: Realm = try! Realm()
  
  func fetchItem(indexPath: IndexPath) -> RestaurantListViewModel? {
    let fetchedItems = Array(realm.objects(RestaurantItem.self))
    guard indexPath.row < fetchedItems.count else {
      return nil
    }
    let restaurantItemModel = fetchedItems[indexPath.row]
    let viewModel = RestaurantListViewModel(model: restaurantItemModel)
    return viewModel
  }
  
  var count: Int {
    return Array(realm.objects(RestaurantItem.self)).count
  }
  
  func write(model: RestaurantListViewModel, completion: () -> ()) {
    
    do {
      try realm.write {
        let favouriteItem  = RestaurantItem()
        favouriteItem.name = model.restaurantName
        favouriteItem.status = model.restaurantStatus
        favouriteItem.isFavourite = try! model.isFavourite.value()
        favouriteItem.sortingValues = SortingValues(bestMatch: model.sortings.bestMatch,
                                                    newest: model.sortings.newest,
                                                    ratingAverage: model.sortings.ratingAverage,
                                                    distance: model.sortings.distance,
                                                    popularity: model.sortings.popularity,
                                                    averageProductPrice: model.sortings.averageProductPrice,
                                                    deliveryCosts: model.sortings.deliveryCosts,
                                                    minCost: model.sortings.minCost)
        realm.add(favouriteItem, update: true)
        completion()
      }
    } catch {
      print("error ! \(error.localizedDescription)")
    }
    
  }
  
  func fetchAllItems() -> [RestaurantItem] {
    return Array(realm.objects(RestaurantItem.self))
  }
}



