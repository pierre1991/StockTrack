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
    @IBOutlet weak var stockSymbol: UILabel!
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
        stockSymbol.text = stock.symbol
        
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
            	
                DispatchQueue.main.async {
                    self.stockPrice.text = "\(NumberFormatter.currencyFormatter(number: stockPrice))"
                    self.openPrice.text = "\(NumberFormatter.currencyFormatter(number: openPrice))"
                    self.highPrice.text = "\(NumberFormatter.currencyFormatter(number: highPrice))"
                    self.lowPrice.text = "\(NumberFormatter.currencyFormatter(number: lowPrice))"
                    self.stockVolume.text = "\(NumberFormatter.decimalFormatter(number: stockVolume))"
                    self.stockMarketCap.text = "\(NumberFormatter.decimalFormatter(number: stockMarketCap))"
                }
            }
        }
    }

}
