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
    
    
    static func lookupStock(stock: String, completion: (stockArray: [Stock]?) -> Void) {
        if let url = NetworkController.lookupStock(stock) {
            NetworkController.dataAtUrl(url, completion: { (data) in
                guard let dataArray = data else {
                    print("no stock lookup")
                    return
                }
                do {
                    let resultArray = try NSJSONSerialization.JSONObjectWithData(dataArray, options: .AllowFragments) as? [[String:AnyObject]]
                    
                    var stockLookupArray: [Stock] = []
                    
                    if let resultArray = resultArray {
                    	for stockLookup in resultArray {
                        	if let stock = Stock(jsonDictionary: stockLookup) {
                            	stockLookupArray.append(stock)
                        	}
                    	}
                    }
                    completion(stockArray: stockLookupArray)
                } catch {
                    print("Error serializing lookupStock data")
                    completion(stockArray: nil)
                    return
                }
            })
        } else {
            completion(stockArray: nil)
        }
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
                    print("Error serializing stockInformation data")
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

/*
[
    {
        "Symbol": "A",
        "Name": "Agilent Technologies Inc",
        "Exchange": "NYSE"
    },
    {
        "Symbol": "A",
        "Name": "Agilent Technologies Inc",
        "Exchange": "BATS Trading Inc"
    },
    {
        "Symbol": "AA",
        "Name": "Alcoa Inc",
        "Exchange": "NYSE"
    },
    {
        "Symbol": "AAON",
        "Name": "AAON Inc",
        "Exchange": "NASDAQ"
    },
    {
        "Symbol": "AAP",
        "Name": "Advance Auto Parts Inc",
        "Exchange": "NYSE"
    },
    {
        "Symbol": "AAPL",
        "Name": "Apple Inc",
        "Exchange": "NASDAQ"
    },
    {
        "Symbol": "AOS",
        "Name": "A. O. Smith Corp",
        "Exchange": "NYSE"
    },
    {
        "Symbol": "BBW",
        "Name": "Build-A-Bear Workshop Inc",
        "Exchange": "NYSE"
    },
    {
        "Symbol": "CAS",
        "Name": "A. M. Castle & Co",
        "Exchange": "NYSE"
    },
    {
        "Symbol": "RCII",
        "Name": "Rent-A-Center Inc",
        "Exchange": "NASDAQ"
    }
]
 */