//
//  Takeaway+UIAlertController.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 11/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    static func showAlert(message: String, buttonTitle: String) -> UIAlertController {
        let alertController = UIAlertController(title: "Warning!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
        alertController.addAction(action)
        return alertController
    }
}
