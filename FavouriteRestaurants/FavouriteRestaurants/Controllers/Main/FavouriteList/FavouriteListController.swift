//
//  FavouriteListController.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 11/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import UIKit

class FavouriteListController: BaseController {
  
  @IBOutlet weak var favouritesTableView: UITableView!
  
  let favouriteDataSource = FavouriteListDataSource()
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // configure tableview
    configureTableView()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let identifier = segue.identifier else {
      return
    }
    switch identifier {
    case Defines.Segue.RestaurantDetailController.identifier:
      let detailController = segue.destination as! RestaurantDetailController
      let vm = favouriteDataSource.fetchItem(indexPath: favouritesTableView.indexPathForSelectedRow!)
      detailController.restaurantViewModel = vm
    default:
      break
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
  }
}
