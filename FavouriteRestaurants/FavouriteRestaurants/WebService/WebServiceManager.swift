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
    
    /// This method request JSON file from local and gives list of RestaurantListViewModel
    ///
    /// - Parameters:
    ///   - path: Resource of local json file.
    ///   - completion: If parsing process complete successfully this callback gives list of RestaurantListViewModel
    ///   - failure: If there will be any parsing or naming issue happens this callback gets call.
    func getRestaurants(path: String, completion: ([RestaurantListViewModel]) -> (), failure: (WebServiceErrorHandler) -> ()) {
        
        if let jsonPathURL = Bundle.main.url(forResource: path, withExtension: "json") {
            guard let jsonData = try? Data(contentsOf: jsonPathURL, options: Data.ReadingOptions.mappedIfSafe) else {
                failure(.noBundleExistError)
                return
            }
            
            guard let jsonDict = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String: Any]
                else {
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
            
            // I had to manipulate resturants array because favourite items stored in user device.
            let favouriteItems = Array(FavouriteListDataSource().fetchAllItems())
            _ = favouriteItems.map { favItem in
                stack.map { resItem in
                    if favItem.name == resItem.restaurantName {
                        resItem.isFavourite.onNext(true)
                    }
                }
            }
            // Call callback to give related view models
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
