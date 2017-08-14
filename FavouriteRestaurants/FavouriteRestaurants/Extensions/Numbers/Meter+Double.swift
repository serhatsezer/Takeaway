//
//  Meter.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 09/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import Foundation

struct Meter {
    var value: Double
    
    init(_ value: Double) {
        self.value = value
    }
    
    var mm: Double { return value * 1000.0 }
    var km: Double { return value / 1000.0 }
}

extension Meter: ExpressibleByFloatLiteral {
    init(floatLiteral value: Double) {
        self.value = value
    }
}
