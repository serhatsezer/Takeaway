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
    let name = "Tanoshii Sushi"
    let expected = "open"
    let sortings = SortingValues()
    let restaurantItem = RestaurantItem(name: name, status: expected, sorting: sortings)
    let restaurantViewModel = RestaurantListViewModel(model: restaurantItem)
    assert(restaurantViewModel.restaurantName == "Tanoshii Sushi", "Given name is not matched")
  }
  
  func testRestaurantRatingAvarage() {
    // Check rating
    let sortings = SortingValues()
    sortings.ratingAverage = 4.5
    let restaurantItem = RestaurantItem(name: "Tanoshii Sushi", status: "open", sorting: sortings)
    let restaurantViewModel = RestaurantListViewModel(model: restaurantItem)
    assert(restaurantViewModel.ratingAvarage == 4.5, "Rating avarage is not passed")
  }
  
  func testRestaurantFavourite() {
    // Check favourite
    let sortings = SortingValues()
    let restaurantItem = RestaurantItem(name: "Tanoshii Sushi", status: "open", sorting: sortings)
    restaurantItem.isFavourite = true
    let restaurantViewModel = RestaurantListViewModel(model: restaurantItem)
    let favouriteValue = try! restaurantViewModel.isFavourite.value()
    assert(favouriteValue == true, "Restaurant favourite case is not passed")
    
  }
  
  //- RestaurantListDataSource tests
  func testDataSourceCount() {
    // test restaurant data count
    let vm1 = RestaurantListViewModel(model: RestaurantItem(name: "Tanoshii Sushi", status: "open", sorting: SortingValues()))
    let vm2 = RestaurantListViewModel(model: RestaurantItem(name: "Tandoori Express", status: "closed", sorting: SortingValues()))
    let vm3 = RestaurantListViewModel(model: RestaurantItem(name: "Royal Thai", status: "order ahead", sorting: SortingValues()))
    
    let viewModels: [RestaurantListViewModel] = [vm1, vm2, vm3]
    let restaurantListDataSource = RestaurantListDataSource(items: viewModels)
    assert(restaurantListDataSource.count == 3, "Restaurant count is not passed")
  }
  
  func testDataSourceFetchItem() {
    // test restaurant data count
    let sortings = SortingValues()
    let firstViewModel = RestaurantListViewModel(model: RestaurantItem(name: "Tanoshii Sushi", status: "open", sorting: sortings))
    let secondViewModel = RestaurantListViewModel(model: RestaurantItem(name: "Tandoori Express", status: "closed", sorting: sortings))
    let thirdViewModel = RestaurantListViewModel(model: RestaurantItem(name: "Royal Thai", status: "order ahead", sorting: sortings))
    
    let viewModels: [RestaurantListViewModel] = [firstViewModel, secondViewModel, thirdViewModel]
    let restaurantListDataSource = RestaurantListDataSource(items: viewModels)
    let firstItemIndexPath = IndexPath(row: 0, section: 0)
    let restaurantItem = restaurantListDataSource.item(at: firstItemIndexPath)
    assert(restaurantItem.restaurantStatus == "open", "Restaurant status is not passed.")
    
  }
  
}
