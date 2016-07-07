//
//  StockController.swift
//  StockTrack
//
//  Created by Pierre on 7/5/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class StockController {
    
    private let kStock = "stocks"
    
    static let sharedController = StockController() 
    
    var stocksArray: [Stock]
    init() {
        stocksArray = []
        loadFromPersistantStorage()
    }
    
    
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
    
    
    
    
    //MARK: NSCoding
    
    func saveToPersistantStorage() {
        NSKeyedArchiver.archiveRootObject(stocksArray, toFile: filePath(kStock))
    }
    
    func loadFromPersistantStorage() {
        let unarchivedStocks = NSKeyedUnarchiver.unarchiveObjectWithFile(filePath(kStock))
        
        if let stocks = unarchivedStocks as? [Stock] {
            self.stocksArray = stocks
        }
    }
    
    func addStock(stock: Stock) {
        stocksArray.append(stock)
        saveToPersistantStorage()
    }
    

    
    func filePath(key: String) -> String {
        let directoryPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .AllDomainsMask, true)
        let documentsPath: AnyObject = directoryPath[0]
        let stockPath = documentsPath.stringByAppendingString("/\(key).plist")
        
        return stockPath
    }
}
