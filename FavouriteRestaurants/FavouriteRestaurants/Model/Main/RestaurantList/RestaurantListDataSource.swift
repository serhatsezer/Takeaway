//
//  RestaurantListDataSource.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 14/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import Foundation


struct RestaurantListDataSource {
    fileprivate var items: [RestaurantListViewModel]!
    
    init(items: [RestaurantListViewModel]) {
        self.items = items
    }
    
    var count: Int {
        return self.items.count
    }
    
    func item(at indexPath: IndexPath) -> RestaurantListViewModel {
        return self.items[indexPath.row]
    }
    
    var restaurants:[RestaurantListViewModel] {
        get {
            return self.items
        }
        set {
            self.items = newValue
        }
    }
}
