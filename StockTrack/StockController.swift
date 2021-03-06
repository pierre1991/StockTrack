//
//  StockController.swift
//  StockTrack
//
//  Created by Pierre on 7/5/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class StockController {
    
    fileprivate let kStock = "stocks"
    
    static let sharedController = StockController()
    
    
    var stocksArray: [Stock] = [
        Stock(name: "Apple Inc", symbol: "AAPL", exchange: "NASDAQ"),
        Stock(name: "Alphabet Inc", symbol: "GOOGL", exchange: "NASDAQ"),
        Stock(name: "Amazon.com Inc", symbol: "AMZN", exchange: "NASDAQ"),
        Stock(name: "Facebook, Inc", symbol: "FB", exchange: "NASDAQ"),
        Stock(name: "Microsoft Corp", symbol: "MSFT", exchange: "NASDAQ"),
        Stock(name: "Twitter Inc", symbol: "TWTR", exchange: "NYSE"),
        Stock(name: "Yahoo! Inc", symbol: "YHOO", exchange: "NASDAQ")
    ]
    
    init() {
        loadFromPersistantStorage()
    }
    
    
	static func lookupStock(_ stock: String, completion: @escaping (_ stockArray: [Stock]?) -> Void) {
        if let url = NetworkController.lookupStock(stock) {
            NetworkController.dataAtUrl(url, completion: { (data) in
                guard let dataArray = data else {
                    print("no stock lookup")
                    return
                }
                do {
                    let resultArray = try JSONSerialization.jsonObject(with: dataArray, options: .allowFragments) as? [[String:AnyObject]]
                    
                    var stockLookupArray: [Stock] = []
                    
                    if let resultArray = resultArray {
                    	for stockLookup in resultArray {
                        	if let stock = Stock(jsonDictionary: stockLookup) {
                            	stockLookupArray.append(stock)
                        	}
                    	}
                    }
                    
                    completion(stockLookupArray)
                } catch {
                    print("Error serializing lookupStock data..\(error.localizedDescription)")
                    completion(nil)
                    return
                }
            })
        } else {
            completion(nil)
        }
    }
    
    
    static func getStockInfo(_ stock: String, completion: @escaping (_ stockInformation: Stock?) -> Void) {
        if let url = NetworkController.searchStockForInfo(stock) {
            NetworkController.dataAtUrl(url, completion: { (data) in
                guard let data = data else {
                    print("Error no data")
                    completion(nil)
                    return
                }
                do {
                    let resultDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:AnyObject]
                    
                    var stockObject: Stock? = nil
                    
                    if let quoteDictionary = resultDictionary {
                        stockObject = Stock(jsonDictionary: quoteDictionary)
                    }
                    
                    completion(stockObject)
                } catch {
                    print("Error serializing getStockInfo data \(error.localizedDescription)")
                    completion(nil)
                    return
                }
            })
        }
    }
    
    

    
    //MARK: NSCoding
    func saveToPersistantStorage() {
        NSKeyedArchiver.archiveRootObject(stocksArray, toFile: filePath(key: kStock))
    }
    
    func loadFromPersistantStorage() {
        let unarchivedStocks = NSKeyedUnarchiver.unarchiveObject(withFile: filePath(key: kStock))
        
        if let stocks = unarchivedStocks as? [Stock] {
            self.stocksArray = stocks
        }
    }
    
    func addStock(_ stock: Stock) {
        stocksArray.append(stock)
        saveToPersistantStorage()
    }
    
    func filePath(key: String) -> String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .allDomainsMask).first
        return (url?.appendingPathComponent(key).path)!
    }

}
