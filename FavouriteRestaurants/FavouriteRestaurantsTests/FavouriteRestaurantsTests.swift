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
    
    //- RestaurantListViewModel tests
    func testRestaurantName() {
        // Check name
        let sortings = SortingValues()
        let name = "Tanoshii"
        let restaurantItem = RestaurantItem(name: name, status: "open", sortings: sortings)
        let restaurantViewModel = RestaurantListViewModel(model: restaurantItem)
        assert(restaurantViewModel.restaurantName == "Tanoshii Sushi", "Given name is not matched")
    }
    
    func testRestaurantRatingAvarage() {
        // Check rating
        var sortings = SortingValues()
        sortings.ratingAverage = 4.0
        let restaurantItem = RestaurantItem(name: "Tanoshii Sushi", status: "open", sortings: sortings)
        let restaurantViewModel = RestaurantListViewModel(model: restaurantItem)
        assert(restaurantViewModel.ratingAvarage == 4.5, "Rating avarage is not passed")
    }
    
    func testRestaurantFavourite() {
        // Check favourite
        let sortings = SortingValues()
        var restaurantItem = RestaurantItem(name: "Tanoshii Sushi", status: "open", sortings: sortings)
        restaurantItem.isFavourite = true
        let restaurantViewModel = RestaurantListViewModel(model: restaurantItem)
        let favouriteValue = try! restaurantViewModel.isFavourite.value()
        assert(favouriteValue == true, "Restaurant favourite case is not passed")

    }
    
    //- RestaurantListDataSource tests
    func testDataSourceCount() {
        // test restaurant data count
        let vm1 = RestaurantListViewModel(model: RestaurantItem(name: "Tanoshii Sushi", status: "open", sortings: SortingValues()))
        let vm2 = RestaurantListViewModel(model: RestaurantItem(name: "Tandoori Express", status: "closed", sortings: SortingValues()))
        let vm3 = RestaurantListViewModel(model: RestaurantItem(name: "Royal Thai", status: "order ahead", sortings: SortingValues()))
        
        let viewModels: [RestaurantListViewModel] = [vm1, vm2, vm3]
        let restaurantListDataSource = RestaurantListDataSource(items: viewModels)
        assert(restaurantListDataSource.count == 3, "Restaurant count is not passed")
    }
    
    func testDataSourceFetchItem() {
        // test restaurant data count
        let vm1 = RestaurantListViewModel(model: RestaurantItem(name: "Tanoshii Sushi", status: "open", sortings: SortingValues()))
        let vm2 = RestaurantListViewModel(model: RestaurantItem(name: "Tandoori Express", status: "closed", sortings: SortingValues()))
        let vm3 = RestaurantListViewModel(model: RestaurantItem(name: "Royal Thai", status: "order ahead", sortings: SortingValues()))
        
        let viewModels: [RestaurantListViewModel] = [vm1, vm2, vm3]
        let restaurantListDataSource = RestaurantListDataSource(items: viewModels)
        let firstItemIndexPath = IndexPath(row: 0, section: 0)
        let restaurantItem = restaurantListDataSource.item(at: firstItemIndexPath)
        assert(restaurantItem.restaurantStatus == "open", "Restaurant status is not passed.")

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
