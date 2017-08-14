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
    
    func getTitle(indexPath: IndexPath) -> String {
        guard indexPath.row > filterItems.count else {
            return ""
        }
        let filterItem = filterItems[indexPath.row]
        return filterItem.filterName
    }
    
    
    func getImagePath(indexPath: IndexPath) -> String {
        guard indexPath.row > filterItems.count else {
            return ""
        }
        let filterItem = filterItems[indexPath.row]
        return filterItem.imagePath
    }
    
    func getFilter(indexPath: IndexPath) -> FilterItem {
        return filterItems[indexPath.row]
    }
    
    var count: Int {
        return filterItems.count
    }
}
