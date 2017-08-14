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
    var isFavourite: BehaviorSubject<Bool>
    
    let disposeBag = DisposeBag()
    
    init(model: RestaurantItem) {
        self.model = model
        
        isFavourite = BehaviorSubject<Bool>(value: self.model.isFavourite)
        isFavourite.subscribe(onNext: { isFav in
            self.model.isFavourite = isFav
        }).addDisposableTo(disposeBag)
    }
    
    var restaurantName: String {
        return model.name
    }
    
    var ratingAvarage: Double {
        return model.sortingValues.ratingAverage
    }
    
    var deliveryCost: String {
        return "Delivery(Min - Max) : \(model.sortingValues.deliveryCosts) - \(model.sortingValues.minCost)"
    }
    
    var distance: String {
        let meter: Meter = Meter(model.sortingValues.distance)
        return "Distance: \(meter.km) Kilometeres"
    }
    
    var restaurantStatus: String {
       return model.status
    }
    
    var sortings: SortingValues {
        return model.sortingValues
    }
}
