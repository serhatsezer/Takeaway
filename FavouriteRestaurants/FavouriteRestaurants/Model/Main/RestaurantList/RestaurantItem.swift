//
//  RestaurantItem.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 09/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import Foundation

struct RestaurantItem: Decodable {
  let name: String
  let status: String
  var isFavourite: Bool = false
  let sortingValues: SortingValues
  
  enum CodingKeys: String, CodingKey {
    case name = "name"
    case status = "status"
    case sortingValues = "sortingValues"
  }
}

struct SortingValues: Decodable {
  let bestMatch: Double
  let newest: Double
  let ratingAverage: Double
  let distance: Double
  let popularity: Double
  let averageProductPrice: Double
  let deliveryCosts: Double
  let minCost: Double
}

