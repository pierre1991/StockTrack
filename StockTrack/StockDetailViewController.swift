//
//  StockDetailViewController.swift
//  StockTrack
//
//  Created by Pierre on 10/12/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit

class StockDetailViewController: UIViewController {

    
    //MARK: Properties
    var stock: Stock?
    
    
    //MARK: IBOutlets
    @IBOutlet weak var stockName: UILabel!
    @IBOutlet weak var stockExchange: UILabel!
    @IBOutlet weak var stockPrice: UILabel!
    @IBOutlet weak var openPrice: UILabel!
    @IBOutlet weak var highPrice: UILabel!
    @IBOutlet weak var lowPrice: UILabel!
    @IBOutlet weak var stockVolume: UILabel!
    @IBOutlet weak var stockMarketCap: UILabel!
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.darkBlueColor()
        
        guard let stock = stock else {return}
        
        stockName.text = stock.name
        stockExchange.text = stock.exchange
        
        getStockInfo()
    }
    
    
    //MARK: IBActions
    @IBAction func refreshButtonTapped(_ sender: AnyObject) {
    	getStockInfo()
    }
    
    
    //MARK: Builder Function
    func getStockInfo() {
        guard let stockSymbol = stock?.symbol else {return}
        
        DispatchQueue.global(qos: .background).async {
            StockController.getStockInfo(stockSymbol) { (stockInfo) in
                guard let stockInfo = stockInfo else {return}
                
                guard let stockPrice = stockInfo.lastPrice,
                    let openPrice = stockInfo.open,
                    let highPrice = stockInfo.high,
                    let lowPrice = stockInfo.low,
                    let stockVolume = stockInfo.volume,
                    let stockMarketCap = stockInfo.marketCap else {return}
                
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                
                let dollarFormatter = NumberFormatter()
                dollarFormatter.numberStyle = .currency
               
                guard let convertedStockPrice = dollarFormatter.string(from: NSNumber(value: stockPrice)) else {return}
                guard let convertedOpenPrice = dollarFormatter.string(from: NSNumber(value: openPrice)) else {return}
                guard let convertedHighPrice = dollarFormatter.string(from: NSNumber(value: highPrice)) else {return}
                guard let convertedLowPrice = dollarFormatter.string(from: NSNumber(value: lowPrice)) else {return}

            	guard let convertedStockVolume = numberFormatter.string(from: NSNumber(value: stockVolume)) else {return}
                guard let convertedMarketCap = numberFormatter.string(from: NSNumber(value: stockMarketCap)) else {return}
            	
                DispatchQueue.main.async {
                    self.stockPrice.text = "\(convertedStockPrice)"
                    self.openPrice.text = "\(convertedOpenPrice)"
                    self.highPrice.text = "\(convertedHighPrice)"
                    self.lowPrice.text = "\(convertedLowPrice)"
                    self.stockVolume.text = "\(convertedStockVolume)"
                    self.stockMarketCap.text = "\(convertedMarketCap)"
                }
            }
        }
    }

}



//        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
//            StockController.getStockInfo(stockSymbol) { (stockInfo) in
//                guard let stockInfo = stockInfo else {return}
//
//                guard let stockPrice = stockInfo.lastPrice,
//                    let openPrice = stockInfo.open,
//                    let highPrice = stockInfo.high,
//                    let lowPrice = stockInfo.low,
//                    let stockVolume = stockInfo.volume,
//                    let stockMarketCap = stockInfo.marketCap else {return}
//
//                DispatchQueue.global().async {
//                    self.stockPrice.text = "$\(stockPrice)"
//                    self.openPrice.text = "$\(openPrice)"
//                    self.highPrice.text = "$\(highPrice)"
//                    self.lowPrice.text = "$\(lowPrice)"
//                    self.stockVolume.text = "\(stockVolume)"
//                    self.stockMarketCap.text = "\(stockMarketCap)"
//                }
//        	}
//        }
