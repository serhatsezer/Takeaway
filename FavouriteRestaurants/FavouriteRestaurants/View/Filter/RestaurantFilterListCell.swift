//
//  RestaurantFilterListCell.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 12/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import UIKit

class RestaurantFilterListCell: UICollectionViewCell {
    
    @IBOutlet weak var filterImageView: UIImageView!
    @IBOutlet weak var filterNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        addCornerRadius()
    }
    
    func configure(model: FilterItem) {
        filterNameLabel.text = model.filterName
        filterImageView.image = UIImage(named: model.imagePath)
    }
    
    func addCornerRadius() {
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
    }
    
    static var CellID: String {
        return String(describing: self)
    }
    
}
