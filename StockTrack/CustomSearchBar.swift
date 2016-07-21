//
//  CustomSearchBar.swift
//  StockTrack
//
//  Created by Pierre on 7/20/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {

    var preferredFont: UIFont!
    var preferredTextColor: UIColor!
    
    init(frame: CGRect, textFont: UIFont, textColor: UIColor) {
        super.init(frame: frame)
        
        self.frame = frame
        preferredFont = textFont
        preferredTextColor = textColor
        
        searchBarStyle = .Prominent
        self.translucent = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func drawRect(rect: CGRect) {
        if let index = indexOfSearchFieldInSubviews() {
            let searchField = subviews[0].subviews[index] as! UITextField
            
            searchField.frame = CGRectMake(5.0, 5.0, self.frame.size.width - 10.0, self.frame.size.height - 10.0)
            searchField.font = preferredFont
            searchField.textColor = preferredTextColor
            
            searchField.backgroundColor = barTintColor
    	}
    
        super.drawRect(rect)
    }

    func indexOfSearchFieldInSubviews() -> Int? {
        print(subviews[0].subviews)
		
        var index: Int!
        let searchBarSubviews = self.subviews[0]
        
        for i in 0 ..< searchBarSubviews.subviews.count {
            if searchBarSubviews.subviews[i].isKindOfClass(UITextField) {
                index = i
                break
            }
    	}
        return index
    }
}
