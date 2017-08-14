//
//  FloatingButton.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 09/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import UIKit

class FloatingButton: UIButton {
    fileprivate var imagePath: String?
    
    init() {
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(imageName: String) {
        self.init(frame: .zero)
        self.imagePath = imageName
        initialize()
    }
    
    func initialize(isConvience: Bool = false) {
        self.layer.cornerRadius  = self.frame.width / 2
        self.layer.masksToBounds = true
        if isConvience {
            self.setImage(UIImage(named: imagePath!), for: .normal)
        }
    }
    
}
