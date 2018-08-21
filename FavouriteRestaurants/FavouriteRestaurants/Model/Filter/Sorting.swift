//
//  Sorting.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 14/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import Foundation

struct Sorting {
  
  /// This method sort given data by mainpulating given data.
  ///
  /// - Parameters:
  ///   - type: It specifies what type of filtering will occur
  ///   - dataSource: It holds necessary models
  ///   - completion: Returns filtered data with manipulated data source
  static func sort(type: FilterType, dataSource: [RestaurantListViewModel], completion: ([RestaurantListViewModel]) -> ()) {
    
    var items = dataSource
    
    switch type {
    case .alphabetically:
      items = items.sorted { $0.restaurantName < $1.restaurantName }
    case .open:
      items = items.sorted { curRes, prevRes in
        curRes.restaurantStatus != "closed" && prevRes.restaurantStatus != "open"
      }
    case .bestMatch:
      items = items.sorted { curRes, prevRes in curRes.sortings.bestMatch > prevRes.sortings.bestMatch}
    case .newest:
      items = items.sorted { curRes, prevRes in curRes.sortings.newest > prevRes.sortings.newest}
    case .ratingAverage:
      items = items.sorted { curRes, prevRes in curRes.sortings.ratingAverage > prevRes.sortings.ratingAverage}
    case .distance:
      items = items.sorted { curRes, prevRes in curRes.sortings.distance < prevRes.sortings.distance}
    case .popularity:
      items = items.sorted { curRes, prevRes in curRes.sortings.popularity > prevRes.sortings.popularity }
    case .averageProductPrice:
      items = items.sorted { curRes, prevRes in curRes.sortings.averageProductPrice > prevRes.sortings.averageProductPrice }
    case .deliveryCosts:
      items = items.sorted { curRes, prevRes in curRes.sortings.deliveryCosts < prevRes.sortings.deliveryCosts }
    case .minCost:
      items = items.sorted { curRes, prevRes in curRes.sortings.minCost < prevRes.sortings.minCost }
    }
    
    // Then we have to re-arrange items according to their favourite flag
    // I know it looks a bit weird but I think there is no way around.
    items = items.sorted(by: { item1,item2 -> Bool in
      return try! item1.isFavourite.value() == true
    })
    
    completion(items)
  }
}
