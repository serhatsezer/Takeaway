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

internal enum SearchControllerState {
  case loading
  case loaded
  case noData
  case error(description: String)
}

class RestaurantListController: BaseController {
  
  // IB Outlets
  @IBOutlet weak fileprivate var restaurantsTableView: UITableView!
  @IBOutlet weak fileprivate var searchBar: UISearchBar!
  @IBOutlet weak fileprivate var floatingButton: FloatingButton!
  
  @IBOutlet weak fileprivate var stateLabel: UILabel!
  fileprivate let disposeBag = DisposeBag()
  
  /// This state holds controller state to hide or show error label
  fileprivate var state: SearchControllerState = .loading {
    didSet {
      switch state {
      case .loading:
        self.stateLabel.isHidden = false
        self.stateLabel.text = "Loading..."
        self.restaurantsTableView.isHidden = true
      case .loaded:
        self.stateLabel.isHidden = true
        self.restaurantsTableView.isHidden = false
        self.restaurantsTableView.reloadData()
      case .noData:
        self.stateLabel.isHidden = false
        self.stateLabel.text = "There are no data to show."
        self.restaurantsTableView.isHidden = true
      case .error(let description):
        self.stateLabel.isHidden = false
        self.stateLabel.text = "Error \(description)"
        self.restaurantsTableView.isHidden = true
      }
    }
  }
  
  // DataSource
  fileprivate var dataSource: RestaurantListDataSource = {
    let dataSource = RestaurantListDataSource(items: [])
    return dataSource
  }()
  
  // Transition
  fileprivate let transition = CircularTransition()
  
  // Delegation
  public weak var delegate: RestaurantListControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // add observer for navigation bar
    addObserverForNavigationBar()
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
    self.state = .loading
    RestaurantServiceProvider().request(.allRestaurant, success: { viewModels in
      self.dataSource = RestaurantListDataSource(items: viewModels)
      self.state = .loaded
    }) { restaurantServiceError in
      self.state = .error(description: restaurantServiceError.localizedDescription)
    }
  }
  
  func configureTableView() {
    restaurantsTableView.delegate = self
    restaurantsTableView.dataSource = self
    restaurantsTableView.rowHeight = UITableViewAutomaticDimension
    restaurantsTableView.estimatedRowHeight = RestaurantListCell.defaultHeight
  }
  
  func addObserverForNavigationBar() {
    searchBar
      .rx
      .text
      .orEmpty
      .debounce(Defines.Config.DebounceInterval, scheduler: MainScheduler.instance) // It will wait 0.5 for changes.
      .distinctUntilChanged()
      .subscribe(onNext: { [unowned self] query in
        let search = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard query.count > 0 else {
          return
        }
      }).disposed(by: disposeBag)
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
