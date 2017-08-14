//
//  BaseController.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 09/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = UIImageView(image: UIImage(named:"lieferando_nav_logo"))

    }
}
