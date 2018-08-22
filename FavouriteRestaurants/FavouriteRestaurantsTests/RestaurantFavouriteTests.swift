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

class RestaurantFavouriteSpec: QuickSpec {
  override func spec() {
    describe("Restaurant favourite") {
      it("should be added favourite", closure: {
        let expected = true
        let actual = false
        let sortings = SortingValues()
        let restaurantItem = RestaurantItem(name: "Tanoshii Sushi", status: "open", sorting: sortings)
        restaurantItem.isFavourite = actual
        let restaurantViewModel = RestaurantListViewModel(model: restaurantItem)
        let favouriteValue = try! restaurantViewModel.isFavourite.value()
        expect(expected).to(equal(favouriteValue))
      })
    }
  }
}
