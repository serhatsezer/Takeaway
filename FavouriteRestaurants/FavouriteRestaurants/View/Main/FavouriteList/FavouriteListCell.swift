//
//  FavouriteListCell.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 12/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import UIKit

class FavouriteListCell: UITableViewCell {
  
  @IBOutlet weak var restaurantNameLabel: UILabel!
  
  var restaurantViewModel: RestaurantListViewModel? {
    didSet {
      configure(model: restaurantViewModel)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  fileprivate func configure(model: RestaurantListViewModel?) {
    guard let vm = restaurantViewModel else {
      return
    }
    restaurantNameLabel.text = vm.restaurantName
  }
  
  static var cellID: String {
    return String(describing: self)
  }
  
  static var defaultHeight: CGFloat {
    return CGFloat(50.0)
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
}
