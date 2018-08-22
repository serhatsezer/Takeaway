//
//  RestaurantDetailController.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 14/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import UIKit

class RestaurantDetailController: UIViewController {
  
  // IB Outlets
  @IBOutlet weak private var addFavouriteButton: UIButton!
  @IBOutlet weak private var productsTableView: UITableView!
  @IBOutlet weak private var restaurantName: UILabel!
  
  // View Models
  public var restaurantViewModel: RestaurantListViewModel?
  private let favouriteDataSource = FavouriteListDataSource()
  
  // Data Source
  let productListDataSource = RestaurantDetailDataSource(items: ["Sample 1", "Sample 2", "Sample 3", "Sample 4", "Sample 5", "Sample 6", "Sample 7", "Sample 8", "Sample 9", "Sample 10"], sections: ["pizza", "hamburger", "hot dog", "döner"])
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let viewModel = restaurantViewModel else {
      return
    }
    
    if let isFavourite = try? viewModel.isFavourite.value() {
      addFavouriteButton.isHidden = isFavourite
    }
    
    self.title = viewModel.restaurantName
    restaurantName.text = viewModel.restaurantName
    // configure table view
    configureTableView()
  }
  
  func configureTableView() {
    self.productsTableView.dataSource = self
    self.productsTableView.delegate = self
  }
  
  @IBAction func addFavouriteTapped(_ sender: Any) {
    guard let viewModel = restaurantViewModel else {
      return
    }
    viewModel.isFavourite.onNext(true)
    
    PersistenceHelper.write(model: viewModel, success: {
      self.showError(message: "Successfully added to favourite list.")
    }) { error in
      self.showError(message: "Error occured: \(error.localizedDescription)")
    }
  }
  
  private func showError(message: String) {
    let messageController = UIAlertController.showAlert(message: message, buttonTitle: "OK")
    present(messageController, animated: true, completion: nil)
  }
}

extension RestaurantDetailController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return productListDataSource.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantDetailListCell.cellID, for: indexPath) as! RestaurantDetailListCell
    return cell
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return productListDataSource.sectionCount
  }
}

extension RestaurantDetailController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return RestaurantDetailListCell.defaultHeight
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return productListDataSource.section(index: section)
  }
}
