//
//  ViewController.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 08/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol RestaurantListControllerDelegate: class {
  func restaurantItemSelected(viewModel: RestaurantListViewModel)
}

class RestaurantListController: BaseController {
  
  // IB Outlets
  @IBOutlet weak fileprivate var restaurantsTableView: UITableView!
  @IBOutlet weak fileprivate var searchBar: UISearchBar!
  @IBOutlet weak fileprivate var floatingButton: FloatingButton!
  
  fileprivate let disposeBag = DisposeBag()
  
  // DataSource
  fileprivate var dataSource: RestaurantListDataSource = {
    let ds = RestaurantListDataSource(items: [])
    return ds
  }()
  
  // Transition
  fileprivate let transition = CircularTransition()
  
  // Delegation
  public weak var delegate: RestaurantListControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // set delegate and datasource and configure cells.
    configureTableView()
    // call web service depending on need (viewWillAppear or viewDidAppear)
    callWebService()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    restaurantsTableView.reloadData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let identifier = segue.identifier else {
      return
    }
    
    switch identifier {
    case Defines.Segue.RestaurantFilterController.identifier:
      let filterController = segue.destination as! RestaurantFilterController
      filterController.filterDelegate = self
      filterController.transitioningDelegate = self
      filterController.modalPresentationStyle = .custom
    default:
      break
    }
  }
}

extension RestaurantListController {
  
  func callWebService() {
    RestaurantServiceProvider().request(.allRestaurant, success: { viewModels in
      self.dataSource = RestaurantListDataSource(items: viewModels)
      DispatchQueue.main.async {
        self.restaurantsTableView.reloadData()
      }
    }) { restaurantServiceError in
      print(restaurantServiceError.localizedDescription)
    }
  }
  
  func configureTableView() {
    restaurantsTableView.delegate = self
    restaurantsTableView.dataSource = self
    restaurantsTableView.rowHeight = UITableViewAutomaticDimension
    restaurantsTableView.estimatedRowHeight = RestaurantListCell.defaultHeight
    searchBar.delegate = self
  }
}

// MARK: - TableView DataSource
extension RestaurantListController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.dataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantListCell.cellID, for: indexPath) as! RestaurantListCell
    cell.restaurantViewModel = dataSource.item(at: indexPath)
    return cell
  }
}

extension RestaurantListController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)

    let selectedViewModel = dataSource.item(at: indexPath)
    delegate?.restaurantItemSelected(viewModel: selectedViewModel)
  }
}

// MARK: - SearchBar Delegate
extension RestaurantListController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //        let searchedArr = restaurants.filter { restaurant -> Bool in
    //            return restaurant.name.lowercased().contains(searchText.lowercased())
    //        }
    //        predicatedRestaurants  = searchText.isEmpty ? restaurants : searchedArr
    //        restaurantsTableView.reloadData()
  }
}

// MARK: - Restaurant Filter Delegate
extension RestaurantListController: RestaurantFilterControllerDelegate {
  func filterItemSelected(item: FilterItem) {
    Sorting.sort(type: item.filterType, dataSource: dataSource.restaurants, completion: { sortedItems in
      dataSource.restaurants = sortedItems
      self.restaurantsTableView.reloadData()
    })
  }
}

// MARK: - Animation Transition
extension RestaurantListController: UIViewControllerTransitioningDelegate {
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    transition.transitionMode = .dismiss
    transition.startingPoint = floatingButton.center
    transition.circleColor = floatingButton.backgroundColor!
    return transition
  }
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    transition.transitionMode = .present
    transition.startingPoint = floatingButton.center
    transition.circleColor = floatingButton.backgroundColor!
    return transition
  }
  
}

