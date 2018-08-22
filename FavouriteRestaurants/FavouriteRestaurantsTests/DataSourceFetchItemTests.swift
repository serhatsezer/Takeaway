//
//  RestaurantNameTests.swift
//  FavouriteRestaurantsTests
//
//  Created by Serhat Sezer on 22.08.2018.
//  Copyright © 2018 Serhat Sezer. All rights reserved.
//

import Quick
import Nimble
@testable import FavouriteRestaurants

class DataSourceFetchItemSpec: QuickSpec {
  override func spec() {
    describe("Data fetch operation") {
      it("should fetch model given index", closure: {
        let sortings = SortingValues()
        let firstViewModel = RestaurantListViewModel(model: RestaurantItem(name: "Tanoshii Sushi", status: "open", sorting: sortings))
        let secondViewModel = RestaurantListViewModel(model: RestaurantItem(name: "Tandoori Express", status: "closed", sorting: sortings))
        let thirdViewModel = RestaurantListViewModel(model: RestaurantItem(name: "Royal Thai", status: "order ahead", sorting: sortings))
        
        let viewModels: [RestaurantListViewModel] = [firstViewModel, secondViewModel, thirdViewModel]
        let restaurantListDataSource = RestaurantListDataSource(items: viewModels)
        let firstItemIndexPath = IndexPath(row: 0, section: 0)
        let restaurantItem = restaurantListDataSource.item(at: firstItemIndexPath)
        let expected = "open"
        expect(expected).to(equal(restaurantItem.restaurantStatus))
      })
    }
  }
}
