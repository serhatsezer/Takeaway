//
//  RequestRepresantable.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 21.08.2018.
//  Copyright © 2018 Serhat Sezer. All rights reserved.
//

import Foundation

protocol RequestRepresentable {
  typealias RequestParameters = [String: Any]
  typealias JSONBody = [String: Any]
  
  var baseURL: URL { get }
  var parameters: RequestParameters { get }
  var bodyData: JSONBody { get }
  var path: String { get }
  var method: RequestMethod { get }
}

enum RequestMethod {
  case post
  case get
  case put
  case delete
}
