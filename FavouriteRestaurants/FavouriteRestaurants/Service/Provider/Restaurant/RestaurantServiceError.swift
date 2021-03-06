//
//  RestaurantServiceError.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 21.08.2018.
//  Copyright © 2018 Serhat Sezer. All rights reserved.
//

import Foundation

// MARK - Error Handler
enum RestaurantServiceError: Error {
  case invalidURLError
  case noBundleExistError
  case jsonParseError
}

extension RestaurantServiceError: CustomStringConvertible {
  var description: String {
    switch self {
    case .invalidURLError:
      return "URL path is invalid."
    case .jsonParseError:
      return "An error occured while parsing JSON file."
    case .noBundleExistError:
      return "There is no such a file"
    }
  }
}
