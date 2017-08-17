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
    @IBOutlet weak var addFavouriteButton: UIButton!
    @IBOutlet weak var productsTableView: UITableView!
    @IBOutlet weak var restaurantName: UILabel!
    
    // View Models
    var restaurantViewModel: RestaurantListViewModel?
    let favouriteDataSource = FavouriteListDataSource()
    
    // Data Source
    let productListDataSource = RestaurantDetailDataSource(items: ["Sample 1", "Sample 2", "Sample 3", "Sample 4", "Sample 5", "Sample 6", "Sample 7", "Sample 8", "Sample 9", "Sample 10"], sections: ["pizza", "hamburger", "hot dog", "döner"])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let vm = restaurantViewModel else {
            return
        }
        
        let isFavourite = try! vm.isFavourite.value()
        addFavouriteButton.isHidden = isFavourite
        
        self.title = vm.restaurantName
        restaurantName.text = vm.restaurantName
        // configure table view
        configureTableView()
    }
    
    func configureTableView() {
        self.productsTableView.dataSource = self
        self.productsTableView.delegate = self
    }
    
    @IBAction func addFavouriteTapped(_ sender: Any) {
        guard let vm = restaurantViewModel else {
            return
        }
        vm.isFavourite.onNext(true)
        favouriteDataSource.write(model: vm) {
            let msgVC = UIAlertController.showAlert(message: "This restaurant added your favourite list.", buttonTitle: "OK")
            present(msgVC, animated: true, completion: nil)
        }
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
