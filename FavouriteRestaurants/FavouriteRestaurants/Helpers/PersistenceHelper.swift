//
//  PersistenceHelper.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 22.08.2018.
//  Copyright © 2018 Serhat Sezer. All rights reserved.
//

import Foundation
import RealmSwift

protocol Persistable {
  /// Writes restaurant item in Realm database
  ///
  /// - Parameter model: Holds all restaurant information
  static func write(model: RestaurantListViewModel, completion: () -> Void)
  
  /// Retuns all Favourite item
  ///
  /// - Returns: Returns list of favourite item
  static func fetchAllItems() -> [RestaurantItem]
  
  /// Removes all persisted items
  static func removeAllItems(success: () -> Void, failure: (Error) -> Void)
}

class PersistenceHelper: Persistable {
  fileprivate static var realm: Realm = try! Realm()
  
  init() {
  }
  
  static func write(model: RestaurantListViewModel, completion: () -> Void) {
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
        realm.autorefresh = true
        completion()
      }
    } catch {
      print("error ! \(error.localizedDescription)")
    }
  }
  
  static func fetchAllItems() -> [RestaurantItem] {
    return realm.objects(RestaurantItem.self).sorted(by: { (res1, res2) -> Bool in
      return res1.name < res2.name
    })
  }
  
  static func removeAllItems(success: () -> Void, failure: (Error) -> Void) {
    do {
      try realm.write {
        realm.deleteAll()
          success()
      }
    } catch let error {
      print("error while removing items")
      failure(error)

    }
  }
  
}
