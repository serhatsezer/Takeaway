//
//  RestaurantListCell.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 09/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import UIKit
import Cosmos
import RxSwift
import RxCocoa

class RestaurantListCell: UITableViewCell {
  
  @IBOutlet weak var restaurantNameLabel: UILabel!
  @IBOutlet weak var restaurantRatingView: CosmosView!
  @IBOutlet weak var restaurantDeliveryCostLabel: UILabel!
  @IBOutlet weak var restaurantDistLabel: UILabel!
  @IBOutlet weak var statusLabel: UILabel!
  @IBOutlet weak var favImageView: UIImageView!
  
  fileprivate let disposeBag = DisposeBag()
  
  /// This observe if restaurantViewModel value is changed or not
  /// Then it calls its configure method
  var restaurantViewModel: RestaurantListViewModel! {
    didSet {
      configure(model: restaurantViewModel)
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  /// This method fill all UI elements and observe if restaurant is favourite or not using reactive cocoa.
  ///
  /// - Parameter model: ViewModel holds all formatted value to fill related UI elements.
  fileprivate func configure(model: RestaurantListViewModel) {
    restaurantNameLabel.text = model.restaurantName
    restaurantRatingView.rating = model.ratingAvarage
    restaurantDeliveryCostLabel.text = model.deliveryCost
    restaurantDistLabel.text = model.distance
    statusLabel.text = model.restaurantStatus
    
    restaurantViewModel.isFavourite.asObserver().subscribe(onNext: { isFav in
      if isFav {
        self.favImageView.image = UIImage(named: "popularity")
      } else {
        self.favImageView.image = nil
      }
    }).addDisposableTo(disposeBag)
    
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    // Configure the view for the selected state
  }
  
  static var cellID: String {
    return String(describing: self)
  }
  
  static var defaultHeight: CGFloat {
    return CGFloat(100.0)
  }
  
}
