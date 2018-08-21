//
//  RestaurantServiceProvider.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 21.08.2018.
//  Copyright © 2018 Serhat Sezer. All rights reserved.
//

import Foundation
import Moya

struct RestaurantServiceProvider: Requestable {
  private let provider = MoyaProvider<RestaurantEndpoint>()
  
  func request(_ endpoint: RestaurantEndpoint, success: @escaping ([RestaurantListViewModel]) -> Void, failure: @escaping (RestaurantServiceError) -> Void) {
    provider.request(endpoint) { result in
      switch result {
      case .success(let response):
        do {
          let jsonDecoder = JSONDecoder()
          let restaurantModels = try jsonDecoder.decode([RestaurantItem].self, from: response.data, keyPath: "restaurants")
          let viewModels = restaurantModels.map { RestaurantListViewModel(model: $0) }.sorted(by: { (current, previous) -> Bool in
            return current.restaurantName < previous.restaurantName
          })
          success(viewModels)
          
        } catch {
          print("error \(error.localizedDescription)")
        }
      case .failure(let error):
        failure(.errorWithDescription(error.localizedDescription))
      }
    }
  }
}

