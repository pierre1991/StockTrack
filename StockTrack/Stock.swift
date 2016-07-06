//
//  Stock.swift
//  StockTrack
//
//  Created by Pierre on 7/5/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class Stock {
    
    private let kName = "Name"
    private let kSymbol = "Symbol"
    private let kLastPrice = "LastPrice"
    private let kMarketCap = "MarketCap"
    private let kVolume = "Volume"
    private let kHigh = "High"
    private let kLow = "Low"
    private let kOpen = "Open"
    
    var name: String?
    var symbol: String?
    var lastPrice: Double?
    var marketCap: Double?
    var volume: Double?
    var high: Double?
    var low: Double?
    var open: Double?
    
    init?(jsonDictionary: [String:AnyObject]) {
        guard let name = jsonDictionary[kName] as? String else {
            self.name = ""
            return nil
        }
        self.name = name
        self.symbol = jsonDictionary[kSymbol] as? String
        self.lastPrice = jsonDictionary[kLastPrice] as? Double
        self.marketCap = jsonDictionary[kMarketCap] as? Double
        self.volume = jsonDictionary[kVolume] as? Double
        self.high = jsonDictionary[kHigh] as? Double
        self.low = jsonDictionary[kLow] as? Double
        self.open = jsonDictionary[kOpen] as? Double
    }
}