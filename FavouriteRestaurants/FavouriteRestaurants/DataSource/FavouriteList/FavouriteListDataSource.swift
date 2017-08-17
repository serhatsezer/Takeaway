//
//  FavouriteListDataSource.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 17/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import Foundation
import RealmSwift

struct FavouriteListDataSource {
    fileprivate var realm: Realm = try! Realm()

    /// Fetchs item from Realm database
    ///
    /// - Parameter indexPath: Given IndexPath value from table view
    /// - Returns: Returns optional view model if requested item already exist in database
    func fetchItem(indexPath: IndexPath) -> RestaurantListViewModel? {
        let fetchedItems = realm.objects(FavouriteItem.self)
        guard indexPath.row < fetchedItems.count else {
            return nil
        }
        let favItem = fetchedItems[indexPath.row]
        let resItem = RestaurantItem(name: favItem.name, status: favItem.status, sortings: SortingValues())
        let viewModel = RestaurantListViewModel(model: resItem)
        return viewModel
    }
    
    /// Returns total count of favourite item
    var count: Int {
        return realm.objects(FavouriteItem.self).count
    }
    
    /// Writes restaurant item in Realm database
    ///
    /// - Parameter model: Holds all restaurant information
    func write(model: RestaurantListViewModel, completion: () -> ()) {
        try! realm.write {
            let favouriteItem  = FavouriteItem()
            favouriteItem.name = model.restaurantName
            favouriteItem.status = model.restaurantStatus
            favouriteItem.isFavourite = try model.isFavourite.value()
            
            let sortings = PersistedSortingValues()
            sortings.bestMatch = model.sortings.bestMatch
            sortings.newest = model.sortings.newest
            sortings.ratingAverage = model.sortings.ratingAverage
            sortings.distance = model.sortings.distance
            sortings.popularity = model.sortings.popularity
            sortings.averageProductPrice = model.sortings.averageProductPrice
            sortings.deliveryCosts = model.sortings.deliveryCosts
            sortings.minCost = model.sortings.minCost
            favouriteItem.sortingValues = sortings
            
            realm.add(favouriteItem, update: true)
            completion()
        }
    }
    
    /// Retuns all Favourite item
    ///
    /// - Returns: Returns list of favourite item
    func fetchAllItems() -> Results<FavouriteItem> {
        return realm.objects(FavouriteItem.self)
    }
}



