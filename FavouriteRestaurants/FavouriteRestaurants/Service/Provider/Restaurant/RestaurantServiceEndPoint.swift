//
//  WebServiceManager.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 09/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import Foundation
import Moya

// MARK: - Provider support
private extension String {
  var urlEscaped: String {
    return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
  }
}

public enum RestaurantEndpoint {
  case allRestaurant
}

extension RestaurantEndpoint: TargetType {
  
  public var baseURL: URL {
    // I'm getting from bundle so there always be json file in there
    return Defines.Config.restaurantsURL
  }
  
  public var path: String {
    switch self {
    case .allRestaurant: // we don't need to use path for the app
      return ""
    }
  }
  
  public var method: Moya.Method {
    return .get
  }
  
  public var sampleData: Data {
    // For testing
    return Data()
  }
  
  public var task: Task {
    return .requestPlain
  }
  
  public var headers: [String : String]? {
    return Defines.Config.defaultHttpHeaders
  }
}




