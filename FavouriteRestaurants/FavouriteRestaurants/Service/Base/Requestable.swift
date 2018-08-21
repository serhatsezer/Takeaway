//
//  Requestable.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 21.08.2018.
//  Copyright © 2018 Serhat Sezer. All rights reserved.
//

import Foundation

protocol Requestable {
  associatedtype Request
  associatedtype Response
  associatedtype Failure
  func request(_ endpoint: Request, success: @escaping (Response) -> Void, failure: @escaping (Failure) -> Void)
}

extension JSONDecoder {
  func decode<T: Decodable>(_ type: T.Type, from data: Data, keyPath: String) throws -> T {
    let toplevel = try JSONSerialization.jsonObject(with: data)
    if let nestedJson = (toplevel as AnyObject).value(forKeyPath: keyPath) {
      let nestedJsonData = try JSONSerialization.data(withJSONObject: nestedJson)
      return try decode(type, from: nestedJsonData)
    } else {
      throw DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "Nested json not found for key path \"\(keyPath)\""))
    }
  }
}
