//
//  RestaurantItem.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 09/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import Foundation

protocol RestaurantItemProtocol {
    var name: String { get set }
    var status: String { get set }
    var sortingValues: SortingValues { get set }
}

struct RestaurantItem: RestaurantItemProtocol {
    var name: String
    var status: String
    var isFavourite: Bool = false
    var sortingValues: SortingValues
   
    init(name: String, status: String, sortings: SortingValues) {
        self.name = name
        self.status = status
        self.sortingValues = sortings
    }
    
    init?(json: [String: Any]) {
        guard let name = json["name"] as? String,
            let status = json["status"] as? String,
            let sortingValues = json["sortingValues"] as? [String: Any] else {
                return nil
        }
        
        self.name = name
        self.status = status // status could be anything beside "open", "close" or "don't accept the order"
        self.sortingValues = SortingValues(json: sortingValues)
    }
    
}

struct SortingValues {
    var bestMatch: Double = 0
    var newest: Double = 0
    var ratingAverage: Double = 0
    var distance: Double = 0.0
    var popularity: Double = 0
    var averageProductPrice: Double = 0
    var deliveryCosts: Double = 0
    var minCost: Double = 0
    
    init() {
        
    }
    
    init(json: [String: Any]) {
        guard let bestMatch = json["bestMatch"] as? Double,
            let newest = json["newest"] as? Double,
            let ratingAverage = json["ratingAverage"] as? Double,
            let distance = json["distance"] as? Double,
            let popularity = json["popularity"] as? Double,
            let averageProductPrice = json["averageProductPrice"] as? Double,
            let deliveryCosts = json["deliveryCosts"] as? Double,
            let minCost = json["minCost"] as? Double else {
                return
        }
        
        self.bestMatch = bestMatch
        self.newest = newest
        self.ratingAverage = ratingAverage
        self.distance = distance
        self.popularity = popularity
        self.averageProductPrice = averageProductPrice
        self.deliveryCosts = deliveryCosts
        self.minCost = minCost
    }
}
