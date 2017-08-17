//
//  WebServiceLogger.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 09/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import Foundation
import RxSwift

struct WebServiceLogger {
    static var shared: WebServiceLogger = WebServiceLogger()
    
    /// If There is any server issues (Like server gets down or other undesirable issues happens) this method
    /// notifies related server.
    /// - Parameters:
    ///   - file: Which file at error occurred
    ///   - line: Which line
    ///   - message: Shows a given message to a user
    /// - Returns: Returns observable to stream it should be async.
    func log(file: String, line: Int, message: String) -> Observable<AnyObject?> {
        print("Successfully logged : \(file) \(line) \(message)")
        
        return Observable.create({ observable -> Disposable in
            // Make dummy server request and then return completion block or signal to show a message.
            // Let assume it successfully sent service
            var fakeData: Data? = "An error occured while fetching resturants".data(using: .utf8)
            observable.onNext(fakeData as AnyObject)
            observable.onCompleted()
            
            // Let assume it failure
            // let error = CustomError(localizedTitle: "Error", localizedDescription: "404 not found", code: 404)
            // observable.onError(error)
            
            return Disposables.create {
                // clean some operations here
                fakeData = nil
            }
        })
    }
}

protocol CustomErrorProtocol: Error {
    var localizedTitle: String { get }
    var localizedDescription: String { get }
    var code: Int { get }
}

struct CustomError: CustomErrorProtocol {
    var localizedTitle: String
    var localizedDescription: String
    var code: Int
    
    init(localizedTitle: String?, localizedDescription: String, code: Int) {
        self.localizedTitle = localizedTitle ?? "Error"
        self.localizedDescription = localizedDescription
        self.code = code
    }
}
