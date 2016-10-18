//
//  Stock.swift
//  StockTrack
//
//  Created by Pierre on 7/5/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class Stock: NSObject, NSCoding {
    
	fileprivate let kName = "Name"
    fileprivate let kSymbol = "Symbol"
    fileprivate let kLastPrice = "LastPrice"
    fileprivate let kMarketCap = "MarketCap"
    fileprivate let kVolume = "Volume"
    fileprivate let kHigh = "High"
    fileprivate let kLow = "Low"
    fileprivate let kOpen = "Open"
    fileprivate let kExchange = "Exchange"
    
    var name: String?
    var symbol: String?
    var lastPrice: Float?
    var marketCap: Float?
    var volume: Float?
    var high: Float?
    var low: Float?
    var open: Float?
    var exchange: String?
    
    init(name: String? = nil, symbol: String? = nil, exchange: String? = nil) {
        self.name = name
        self.symbol = symbol
        self.exchange = exchange
    }
    
    
    init?(jsonDictionary: [String:AnyObject]) {
        guard let name = jsonDictionary[kName] as? String else {
            self.name = ""
            return nil
        }
        
        self.name = name
        self.symbol = jsonDictionary[kSymbol] as? String
        self.lastPrice = jsonDictionary[kLastPrice] as? Float
        self.marketCap = jsonDictionary[kMarketCap] as? Float
        self.volume = jsonDictionary[kVolume] as? Float
        self.high = jsonDictionary[kHigh] as? Float
        self.low = jsonDictionary[kLow] as? Float
        self.open = jsonDictionary[kOpen] as? Float
        self.exchange = jsonDictionary[kExchange] as? String
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: kName)
        aCoder.encode(symbol, forKey: kSymbol)
        aCoder.encode(exchange, forKey: kExchange)
    }
    
    required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: kName) as? String,
            let symbol = aDecoder.decodeObject(forKey: kSymbol) as? String,
        	let exchange = aDecoder.decodeObject(forKey: kExchange) as? String else {return}
        
        self.name = name
        self.symbol = symbol
        self.exchange = exchange
    }
}
