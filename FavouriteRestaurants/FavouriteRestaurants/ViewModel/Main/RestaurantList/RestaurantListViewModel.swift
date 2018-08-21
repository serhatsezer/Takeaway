//
//  File.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 09/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import Foundation
import RxSwift

/*
 Protocols that describe what something is should read as nouns (e.g. Collection). Protocols that describe a capability should be named using the suffixes able, ible, or ing (e.g. Equatable, ProgressReporting).
 */
protocol RestaurantListViewModelRepresantable: class {
  
  /// Decides if selected restaurant favourite or not.
//  var isFavourite: BehaviorSubject<Bool> { get set }
  
  /// Returns formatted restaurant name
  var restaurantName: String { get }
  
  /// Returns restaurant avarage rate
  var ratingAvarage: Double { get }
  
  /// Returns restaurant delivery cost with formatted style
  var deliveryCost: String { get }
  
  /// Returns distance value by km type
  var distance: String { get }
  
  /// Returns restaurant status
  var restaurantStatus: String { get }
  
  /// Returns restaurant all sorting values like: (newer, popular, min price, etc.)
  var sortings: SortingValues { get  }
}

class RestaurantListViewModel: RestaurantListViewModelRepresantable {
  
  fileprivate var model: RestaurantItem!
  fileprivate let disposeBag = DisposeBag()
  
  var isFavourite: BehaviorSubject<Bool>
  
  init(model: RestaurantItem) {
    self.model = model
    isFavourite = BehaviorSubject<Bool>(value: self.model.isFavourite)
  }
  
  var restaurantName: String {
    return model.name
  }
  
  var ratingAvarage: Double {
    guard let sortingValues = model.sortingValues else { return 0.0 }
    return sortingValues.ratingAverage
  }
  
  var deliveryCost: String {
    guard let sortingValues = model.sortingValues else { return "" }
    return "Delivery(Min - Max) : \(sortingValues.deliveryCosts) - \(sortingValues.minCost)"
  }
  
  var distance: String {
    guard let sortingValues = model.sortingValues else { return "" }
    let meter: Meter = Meter(sortingValues.distance)
    return "Distance: \(meter.km) Kilometeres"
  }
  
  var restaurantStatus: String {
    return model.status
  }
  
  var sortings: SortingValues {
    return model.sortingValues!
  }
}
