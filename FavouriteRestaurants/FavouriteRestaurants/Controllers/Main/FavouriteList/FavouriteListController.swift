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

class FavouriteListController: BaseController {
  
  @IBOutlet weak fileprivate var favouritesTableView: UITableView!
  
  fileprivate let favouriteDataSource = FavouriteListDataSource()
  weak var delegate: FavouriteListControllerDelegate?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // configure tableview
    configureTableView()
  }
  
  @IBAction func removeAllTapped(_ sender: UIBarButtonItem) {
    PersistenceHelper.removeAllItems(success: {
      let messageController = UIAlertController.showAlert(message: "All items are deleted!", buttonTitle: "OK")
      present(messageController, animated: true, completion: nil)
    }) { error in
      let messageController = UIAlertController.showAlert(message: error.localizedDescription, buttonTitle: "OK")
      present(messageController, animated: true, completion: nil)
    }
  }
}

extension FavouriteListController {
  func configureTableView() {
    favouritesTableView.dataSource = self
    favouritesTableView.delegate = self
    favouritesTableView.tableFooterView = UIView()
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
