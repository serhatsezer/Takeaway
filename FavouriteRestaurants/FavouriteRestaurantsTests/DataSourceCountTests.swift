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

class DataSourceCountSpec: QuickSpec {
  override func spec() {
    describe("Data model count") {
      it("should give appropriate number", closure: {
        let sortings = SortingValues()
        let firstViewModel = RestaurantListViewModel(model: RestaurantItem(name: "Tanoshii Sushi", status: "open", sorting: sortings))
        let secondViewModel = RestaurantListViewModel(model: RestaurantItem(name: "Tandoori Express", status: "closed", sorting: sortings))
        let thirdViewModel = RestaurantListViewModel(model: RestaurantItem(name: "Royal Thai", status: "order ahead", sorting: sortings))
        let viewModels: [RestaurantListViewModel] = [firstViewModel, secondViewModel, thirdViewModel]
        let restaurantListDataSource = RestaurantListDataSource(items: viewModels)
        let expected = restaurantListDataSource.count
        let actual = 3
        expect(expected).to(equal(actual))
      })
    }
  }
}
