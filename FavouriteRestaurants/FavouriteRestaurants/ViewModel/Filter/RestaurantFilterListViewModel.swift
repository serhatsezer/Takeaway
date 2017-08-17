//
//  RestaurantFilterListViewModel.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 12/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import Foundation

struct RestaurantFilterListViewModel {
    fileprivate var filterItems = [FilterItem]()
    
    init(titles: [FilterItem]) {
        self.filterItems = titles
    }
    
    /// Get related title string given by index path
    ///
    /// - Parameter indexPath: Associated table view indexPath
    /// - Returns: Returns related string from given array
    func getTitle(indexPath: IndexPath) -> String {
        guard indexPath.row > filterItems.count else {
            return ""
        }
        let filterItem = filterItems[indexPath.row]
        return filterItem.filterName
    }
    
    
    /// Get related image path given by index path
    ///
    /// - Parameter indexPath: Associated table view indexPath
    /// - Returns: Returns image path
    func getImagePath(indexPath: IndexPath) -> String {
        guard indexPath.row > filterItems.count else {
            return ""
        }
        let filterItem = filterItems[indexPath.row]
        return filterItem.imagePath
    }
    
    /// Get related filter model item
    ///
    /// - Parameter indexPath: Associated table view indexPath
    /// - Returns: Returns filter model
    func getFilter(indexPath: IndexPath) -> FilterItem {
        return filterItems[indexPath.row]
    }
    
    /// Returns filter model count if there is no it returns zero.
    var count: Int {
        return filterItems.count
    }
}
