//
//  ResponseRepresantable.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 21.08.2018.
//  Copyright © 2018 Serhat Sezer. All rights reserved.
//

import Foundation

public protocol ResponseRepresentable {
  typealias JSON = [String: Any]
  var response: JSON { get set }
}
