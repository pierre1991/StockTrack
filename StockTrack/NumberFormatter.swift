//
//  NumberFormatter.swift
//  StockTrack
//
//  Created by Pierre on 10/19/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

extension NumberFormatter {
    
    class func decimalFormatter(number: Float) -> String {
        let decimalFormatter = NumberFormatter()
        decimalFormatter.numberStyle = .decimal
        
        guard let convertedDecimal = decimalFormatter.string(from: NSNumber(value: number)) else {return ""}
        
        return convertedDecimal
    }
    
    class func currencyFormatter(number: Float) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        
        guard let convertedCurrency = currencyFormatter.string(from: NSNumber(value: number)) else {return ""}
        
        return convertedCurrency
    }
    
}
