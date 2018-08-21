//
//  FilterItem.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 12/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import Foundation

enum FilterType: String {
  case alphabetically
  case open
  case bestMatch
  case newest
  case ratingAverage
  case distance
  case popularity
  case averageProductPrice
  case deliveryCosts
  case minCost
}


/// This Filter item used by sorting controller
struct FilterItem {
  let filterName: String
  let imagePath: String
  let filterType: FilterType
}
