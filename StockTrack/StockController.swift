//
//  StockController.swift
//  StockTrack
//
//  Created by Pierre on 7/5/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class StockController {
    
    static let sharedController = StockController() 
    
    var stocks: [Stock] = []
    
    
    static func searchStockForInformation(quote: String, completion: (stock: Stock?) -> Void) {
        if let url = NetworkController.searchStockQuote(quote) {
            NetworkController.dataAtUrl(url) { (data) -> Void in
                guard let data = data else {
                    print("no stock data")
                    return
                }
                do {
                    let resultDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    
                    var stockObject: Stock?
                    
                    if let quoteDictionary = resultDictionary as? [String:AnyObject] {
                        stockObject = Stock(jsonDictionary: quoteDictionary)
                    }
                    completion(stock: stockObject)
                } catch {
                    print("Error serializing data")
                    completion(stock: nil)
                    return
                }
            }
        }
    }
}
