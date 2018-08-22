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

class RestaurantNameSpec: QuickSpec {
  override func spec() {
    describe("Restaurant name maching") {
      it("should match with given view model name", closure: {
        let expected = "Tanoshii Sushi"
        let actual = "Tanoshii Sushi"
        let sortings = SortingValues()
        let restaurantItem = RestaurantItem(name: actual, status: "open", sorting: sortings)
        let restaurantViewModel = RestaurantListViewModel(model: restaurantItem)
        expect(expected).to(equal(restaurantViewModel.restaurantName))
      })
    }
  }
}
