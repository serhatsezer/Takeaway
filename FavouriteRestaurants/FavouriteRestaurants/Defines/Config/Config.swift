//
//  Config.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 21.08.2018.
//  Copyright © 2018 Serhat Sezer. All rights reserved.
//

import Foundation

struct Defines {
  struct Config {
    // For to get benifet from Moya I had to use github URL 
    static let restaurantsURL = URL(string: "https://raw.githubusercontent.com/serhatsezer/Takeaway/master/FavouriteRestaurants/FavouriteRestaurants/Externals/JSON/restaurants.json")!
    static let defaultHttpHeaders = [String: String]()
  }
  
  enum Segue: String {
    case RestaurantDetailController
    var identifier: String {
      return self.rawValue
    }
  }
}
