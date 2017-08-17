//
//  File.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 09/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import Foundation
import RxSwift

class RestaurantListViewModel {
    
    fileprivate var model: RestaurantItem!
    fileprivate let disposeBag = DisposeBag()

    /// Decides if selected restaurant favourite or not.
    var isFavourite: BehaviorSubject<Bool>
    
    init(model: RestaurantItem) {
        self.model = model
        
        isFavourite = BehaviorSubject<Bool>(value: self.model.isFavourite)
        isFavourite.subscribe(onNext: { isFav in
            self.model.isFavourite = isFav
        }).addDisposableTo(disposeBag)
    }
    
    /// Returns formatted restaurant name
    var restaurantName: String {
        return model.name
    }
    
    /// Returns restaurant avarage rate
    var ratingAvarage: Double {
        return model.sortingValues.ratingAverage
    }
    
    /// Returns restaurant delivery cost with formatted style
    var deliveryCost: String {
        return "Delivery(Min - Max) : \(model.sortingValues.deliveryCosts) - \(model.sortingValues.minCost)"
    }
    
    /// Returns distance value by km type
    var distance: String {
        let meter: Meter = Meter(model.sortingValues.distance)
        return "Distance: \(meter.km) Kilometeres"
    }
    
    /// Returns restaurant status
    var restaurantStatus: String {
       return model.status
    }
    
    
    /// Returns restaurant all sorting values like: (newer, popular, min price, etc.)
    var sortings: SortingValues {
        return model.sortingValues
    }
}
