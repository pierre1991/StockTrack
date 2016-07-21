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
        UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: .Default)
        
        UINavigationBar.appearance().titleTextAttributes = [
            NSForegroundColorAttributeName:UIColor.mintGreenColor(),
            NSFontAttributeName: UIFont(name: "Avenir-Book", size: 26)!
        ]
        
        
    }
}