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
    @IBOutlet weak var restaurantTitleLabel: UILabel!
    @IBOutlet weak var addFavouriteButton: UIButton!
    
    // View Models
    var restaurantViewModel: RestaurantListViewModel?
    let favouriteDataSource = FavouriteListDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let vm = restaurantViewModel else {
            return
        }
        
        let isFavourite = try! vm.isFavourite.value()
        addFavouriteButton.isHidden = isFavourite
        self.title = vm.restaurantName
        self.restaurantTitleLabel.text = vm.restaurantName
    }

    @IBAction func addFavouriteTapped(_ sender: Any) {
        guard let vm = restaurantViewModel else {
            return
        }
        vm.isFavourite.onNext(true)
        favouriteDataSource.write(model: vm)
    }
}
