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
        
        searchBarStyle = .prominent
        self.isTranslucent = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    override func draw(_ rect: CGRect) {
        if let index = indexOfSearchFieldInSubviews() {
            let searchField = subviews[0].subviews[index] as! UITextField
            
            searchField.frame = CGRect(x: 5.0, y: 5.0, width: self.frame.size.width - 10.0, height: self.frame.size.height - 10.0)
            searchField.font = preferredFont
            searchField.textColor = preferredTextColor
            
            searchField.backgroundColor = barTintColor
    	}
    
        
        let path = UIBezierPath()
        let startPoint = CGPoint(x: 0.0, y: frame.size.height)
        let endPoint = CGPoint(x: frame.size.width, y: frame.size.height)
        path.move(to: startPoint)
        path.addLine(to: endPoint)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.strokeColor = preferredTextColor.cgColor
        shapeLayer.lineWidth = 1.0
        
        layer.addSublayer(shapeLayer)
        
        
        super.draw(rect)
    }

    func indexOfSearchFieldInSubviews() -> Int? {
    	var index: Int!
        let searchBarSubviews = self.subviews[0]
        
        for i in 0 ..< searchBarSubviews.subviews.count {
            if searchBarSubviews.subviews[i].isKind(of: UITextField.self) {
                index = i
                break
            }
    	}
        
        return index
    }
}
