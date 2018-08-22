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

class RestaurantRatingAvarageSpec: QuickSpec {
  override func spec() {
    describe("Restaurant average") {
      it("should be matched given restaurant average", closure: {
        let expected = 4.5
        let actual = 4.0
        let sortings = SortingValues()
        sortings.ratingAverage = actual
        let restaurantItem = RestaurantItem(name: "Tanoshii Sushi", status: "open", sorting: sortings)
        let restaurantViewModel = RestaurantListViewModel(model: restaurantItem)
        expect(expected).to(equal(restaurantViewModel.sortings.ratingAverage))
      })
    }
  }
}
