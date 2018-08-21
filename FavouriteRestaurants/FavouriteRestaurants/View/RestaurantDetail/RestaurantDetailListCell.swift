//
//  RestaurantDetailListCell.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 18/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import UIKit

class RestaurantDetailListCell: UITableViewCell {
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  static var cellID: String {
    return String(describing: self)
  }
  
  static var defaultHeight: CGFloat {
    return CGFloat(80.0)
  }
}
