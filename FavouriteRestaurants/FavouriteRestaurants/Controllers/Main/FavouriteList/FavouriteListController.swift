//
//  FavouriteListController.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 11/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import UIKit

protocol FavouriteListControllerDelegate: class {
  func favouriteRestaurantSelected(viewModel: RestaurantListViewModel)
}

internal enum FavouriteControllerState {
  case loading
  case loaded
  case noData
  case error(description: String)
}

class FavouriteListController: BaseController {
  
  @IBOutlet weak fileprivate var favouritesTableView: UITableView!
  
  @IBOutlet weak private var stateLabel: UILabel!
  fileprivate let favouriteDataSource = FavouriteListDataSource()
  weak var delegate: FavouriteListControllerDelegate?
  
  fileprivate var state: FavouriteControllerState = .loading {
    didSet {
      switch state {
      case .loading:
        self.stateLabel.isHidden = false
        self.stateLabel.text = "Loading..."
        self.favouritesTableView.isHidden = true
      case .loaded:
        self.stateLabel.isHidden = true
        self.favouritesTableView.isHidden = false
        self.favouritesTableView.reloadData()
      case .noData:
        self.stateLabel.isHidden = false
        self.stateLabel.text = "There are no data to show."
        self.favouritesTableView.isHidden = true
      case .error(let description):
        self.stateLabel.isHidden = false
        self.stateLabel.text = "Error \(description)"
        self.favouritesTableView.isHidden = true
      }
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // check data status
    checkDataStatus()
    
    // configure tableview
    configureTableView()
  }
  
  @IBAction func removeAllTapped(_ sender: UIBarButtonItem) {
    PersistenceHelper.removeAllItems(success: {
      let messageController = UIAlertController.showAlert(message: "All items are deleted!", buttonTitle: "OK")
      present(messageController, animated: true, completion: nil)
      self.state = .noData
    }) { error in
      let messageController = UIAlertController.showAlert(message: error.localizedDescription, buttonTitle: "OK")
      present(messageController, animated: true, completion: nil)
      self.state = .error(description: error.localizedDescription)
    }
  }
}

extension FavouriteListController {
  func configureTableView() {
    favouritesTableView.dataSource = self
    favouritesTableView.delegate = self
    favouritesTableView.tableFooterView = UIView()
  }
  
  func checkDataStatus() {
    if favouriteDataSource.count == 0 {
      self.state = .noData
    } else {
      self.state = .loaded
    }
    favouritesTableView.reloadData()
  }
}

extension FavouriteListController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favouriteDataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteListCell.cellID, for: indexPath) as! FavouriteListCell
    cell.restaurantViewModel = favouriteDataSource.fetchItem(indexPath: indexPath)
    return cell
  }
}

extension FavouriteListController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    let viewModel = favouriteDataSource.fetchItem(indexPath: indexPath)!
    delegate?.favouriteRestaurantSelected(viewModel: viewModel)
  }
}
