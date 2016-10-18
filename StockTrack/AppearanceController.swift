//
//  AppearanceController.swift
//  StockTrack
//
//  Created by Pierre on 7/6/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation
import UIKit

class AppearanceController {
    
    static func initializeAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor.darkBlueColor()
        UINavigationBar.appearance().tintColor = UIColor.mintGreenColor()
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
//        UINavigationBar.appearance().layer.shadowColor = UIColor.mintGreenColor().cgColor
//        UINavigationBar.appearance().layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//        UINavigationBar.appearance().layer.shadowRadius = 4.0
//        UINavigationBar.appearance().layer.shadowOpacity = 1.0

        UINavigationBar.appearance().titleTextAttributes = [
            NSForegroundColorAttributeName:UIColor.mintGreenColor(),
            NSFontAttributeName: UIFont(name: "Avenir-Book", size: 26)!
        ]
        
        
    }
}
