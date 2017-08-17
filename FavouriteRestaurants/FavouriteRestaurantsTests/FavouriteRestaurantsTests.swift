//
//  FavouriteRestaurantsTests.swift
//  FavouriteRestaurantsTests
//
//  Created by Serhat Sezer on 08/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import XCTest
@testable import FavouriteRestaurants

class FavouriteRestaurantsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRestaurantName() {
        // Check name
        let sortings = SortingValues()
        let restaurantItem = RestaurantItem(name: "Tanoshii", status: "open", sortings: sortings)
        let restaurantViewModel = RestaurantListViewModel(model: restaurantItem)
        assert(restaurantViewModel.restaurantName == "Tanoshii Sushi", "Given name is not matched")
    }
    
    func testRestaurantRatingAvarage() {
        // Check rating
        var sortings = SortingValues()
        sortings.ratingAverage = 4.5
        let restaurantItem = RestaurantItem(name: "Tanoshii Sushi", status: "open", sortings: sortings)
        let restaurantViewModel = RestaurantListViewModel(model: restaurantItem)
        assert(restaurantViewModel.ratingAvarage == 4.5, "Rating avarage is not correct")
    }
    
    func testRestaurantFavourite() {
        // Check favourite
        let sortings = SortingValues()
        var restaurantItem = RestaurantItem(name: "Tanoshii Sushi", status: "open", sortings: sortings)
        restaurantItem.isFavourite = true
        let restaurantViewModel = RestaurantListViewModel(model: restaurantItem)
        let favouriteValue = try! restaurantViewModel.isFavourite.value()
        assert(favouriteValue == true, "Restaurant is not favourite")
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
