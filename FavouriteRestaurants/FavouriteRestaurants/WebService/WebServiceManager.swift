//
//  WebServiceManager.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 09/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import Foundation



class WebServiceManager {
    
    static var shared: WebServiceManager = WebServiceManager()
    
    func getRestaurants(path: String, completion: ([RestaurantListViewModel]) -> (), failure: (WebServiceErrorHandler) -> ()) {
        
        if let jsonPathURL = Bundle.main.url(forResource: path, withExtension: "json") {
            guard let jsonData = try? Data(contentsOf: jsonPathURL, options: Data.ReadingOptions.mappedIfSafe) else {
                print("Bundle error")
                failure(.noBundleExistError)
                return
            }
            
            guard let jsonDict = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any]
                else {
                    print("Parsing error")
                    failure(.jsonParseError)
                    return
            }
            var stack = [RestaurantListViewModel]()
            if let restaurants = jsonDict?["restaurants"] as? [[String: Any]] {
                _ = restaurants.map { restaurantDict in
                    let restaurant = RestaurantItem(json: restaurantDict)!
                    let viewModel  = RestaurantListViewModel(model: restaurant)
                    stack.append(viewModel)
                }
            }
            
            completion(stack)
            
        } else {
            // If json path is not valid
            failure(.invalidURLError)
        }
    }

}

// MARK - Error Handler

enum WebServiceErrorHandler {
    case invalidURLError
    case noBundleExistError
    case jsonParseError
}

extension WebServiceErrorHandler: CustomStringConvertible {
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
