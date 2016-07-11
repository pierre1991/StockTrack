//
//  Stock.swift
//  StockTrack
//
//  Created by Pierre on 7/5/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class Stock: NSObject, NSCoding {
    
	private let kName = "Name"
    private let kSymbol = "Symbol"
    private let kLastPrice = "LastPrice"
    private let kMarketCap = "MarketCap"
    private let kVolume = "Volume"
    private let kHigh = "High"
    private let kLow = "Low"
    private let kOpen = "Open"
    
    private let kExchange = "Exchange"
    
    var name: String?
    var symbol: String?
    var lastPrice: Float?
    var marketCap: Float?
    var volume: Float?
    var high: Float?
    var low: Float?
    var open: Float?
    
    var exchange: String?
    
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
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: kName)
    }
    
    @objc required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObjectForKey(kName) as? String else {
            self.name = ""
            
            super.init()
            return nil
        }
        self.name = name
        super.init()
    }
}


















