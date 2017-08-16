//
//  FavouriteListViewModel.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 11/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import Foundation
import RealmSwift

/**
 This model responsible for writing persistent model and fetching FavouriteItem by given position
 */
struct FavouriteListViewModel {
    fileprivate var realm: Realm = try! Realm()
    /**
     This method writes necessary informations on Realm
     
     - parameter model: holds all necessary inforamation related to restaurant.
     */
    func write(model: RestaurantListViewModel) {
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
            
            realm.add(favouriteItem)
        }
    }
    
    func fetchAllItems() -> Results<FavouriteItem> {
//        var favItems = [FavouriteItem]()
//        let b  = realm.objects(FavouriteItem.self).map { item in
//            favItems.append(item)
//        }
        return realm.objects(FavouriteItem.self)
    }
    
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
    
    var count: Int {
        return realm.objects(FavouriteItem.self).count
    }
    
}
