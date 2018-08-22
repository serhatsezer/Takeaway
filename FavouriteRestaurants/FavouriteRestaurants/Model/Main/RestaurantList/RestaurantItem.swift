//
//  RestaurantItem.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 09/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class RestaurantItem: Object, Codable {
  @objc dynamic var name: String = ""
  @objc dynamic var status: String = ""
  @objc dynamic var isFavourite: Bool = false
  @objc dynamic var sortingValues: SortingValues? = nil
  
  override static func primaryKey() -> String? {
    return "name"
  }
  
  convenience init(name: String, status: String, sorting: SortingValues) {
    self.init()
    self.name = name
    self.status = status
    self.sortingValues = sorting
  }
  
  enum CodingKeys: String, CodingKey {
    case name = "name"
    case status = "status"
    case sortingValues = "sortingValues"
  }
}



class SortingValues: Object, Codable {
  @objc dynamic var bestMatch: Double = 0.0
  @objc dynamic var newest: Double = 0.0
  @objc dynamic var ratingAverage: Double = 0.0
  @objc dynamic var distance: Double = 0.0
  @objc dynamic var popularity: Double = 0.0
  @objc dynamic var averageProductPrice: Double = 0.0
  @objc dynamic var deliveryCosts: Double = 0.0
  @objc dynamic var minCost: Double = 0.0
  
  convenience init(bestMatch: Double, newest: Double, ratingAverage: Double, distance: Double, popularity: Double, averageProductPrice: Double, deliveryCosts: Double, minCost: Double) {
    self.init()
    self.bestMatch = bestMatch
    self.newest = newest
    self.ratingAverage = ratingAverage
    self.distance = distance
    self.popularity = popularity
    self.averageProductPrice = averageProductPrice
    self.deliveryCosts = deliveryCosts
    self.minCost = minCost
  }
  
}

