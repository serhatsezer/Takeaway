//
//  FavouriteItem.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 11/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import Foundation
import RealmSwift

class FavouriteItem: Object {
    dynamic var name: String = ""
    dynamic var status: String = ""
    dynamic var isFavourite: Bool = false
    dynamic var sortingValues: PersistedSortingValues!
    
    convenience init(model: RestaurantItem) {
        self.init()
        self.name = model.name
        self.status = model.status
        self.isFavourite = model.isFavourite
        self.sortingValues = PersistedSortingValues(model: model.sortingValues)
    }
    
    override static func primaryKey() -> String? {
        return "name"
    }
}

class PersistedSortingValues: Object {
    dynamic var bestMatch: Double = 0
    dynamic var newest: Double = 0
    dynamic var ratingAverage: Double = 0
    dynamic var distance: Double = 0.0
    dynamic var popularity: Double = 0
    dynamic var averageProductPrice: Double = 0
    dynamic var deliveryCosts: Double = 0
    dynamic var minCost: Double = 0
    
    convenience init(model: SortingValues) {
        self.init()
        
        self.bestMatch = model.bestMatch
        self.newest = model.newest
        self.ratingAverage = model.ratingAverage
        self.distance = model.distance
        self.popularity = model.popularity
        self.averageProductPrice = model.averageProductPrice
        self.deliveryCosts = model.deliveryCosts
        self.minCost = model.minCost
    }
}



