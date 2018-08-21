//
//  RestaurantFilterController.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 12/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import UIKit

protocol RestaurantFilterControllerDelegate: class {
  func filterItemSelected(item: FilterItem)
}

class RestaurantFilterController: UIViewController {
  @IBOutlet weak var collectionView: UICollectionView!
  
  weak var filterDelegate: RestaurantFilterControllerDelegate?
  
  let viewModel = RestaurantFilterListViewModel(titles: [
    FilterItem(filterName: "Best Match", imagePath: "best_match", filterType: .bestMatch),
    FilterItem(filterName: "Newest", imagePath: "newest", filterType: .newest),
    FilterItem(filterName: "Rating Avarage", imagePath: "popularity", filterType: .ratingAverage),
    FilterItem(filterName: "Distance", imagePath: "distance", filterType: .distance),
    FilterItem(filterName: "Popularity", imagePath: "popularity", filterType: .popularity),
    FilterItem(filterName: "Product price", imagePath: "product_price", filterType: .averageProductPrice),
    FilterItem(filterName: "Delivery costs", imagePath: "delivery_cost", filterType: .deliveryCosts),
    FilterItem(filterName: "Min. order amount", imagePath: "min_order_amount", filterType: .minCost),
    FilterItem(filterName: "Alphabetical", imagePath: "alphabetically", filterType: .alphabetically)])
  
  override func viewDidLoad() {
    super.viewDidLoad()
    collectionView.dataSource = self
    collectionView.delegate = self
    
    let screenWidth = UIScreen.main.bounds.width
    let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
    
    layout.sectionInset = UIEdgeInsets(top: 50, left: 10, bottom: 10, right: 10)
    layout.itemSize = CGSize(width: screenWidth/2 - 20, height: 60)
    layout.minimumInteritemSpacing = 0
    layout.minimumLineSpacing = 10
    collectionView!.collectionViewLayout = layout
    
    
  }
}

extension RestaurantFilterController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RestaurantFilterListCell.CellID, for: indexPath) as! RestaurantFilterListCell
    cell.configure(model: viewModel.getFilter(indexPath: indexPath))
    
    return cell
  }
}

extension RestaurantFilterController: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    if let filterDelegate = filterDelegate {
      filterDelegate.filterItemSelected(item: viewModel.getFilter(indexPath: indexPath))
      dismiss(animated: true, completion: nil)
    }
  }
}

