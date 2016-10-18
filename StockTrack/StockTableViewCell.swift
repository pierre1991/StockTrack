//
//  StockTableViewCell.swift
//  StockTrack
//
//  Created by Pierre on 7/5/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit

class StockTableViewCell: UITableViewCell {


    //MARK: IBOutlets
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var stockName: UILabel!
    @IBOutlet weak var stockInfo: UILabel!
    
    
    
	override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    //MARK: Builder Function
    func updateCell(_ stock: Stock) {
        self.stockName.text = stock.name
		
        guard let stockSymbol = stock.symbol else {return}

        StockController.getStockInfo(stockSymbol, completion: { (stockInfo) in
            guard let stockInfo = stockInfo else {return}

            if let stockLastPrice = stockInfo.lastPrice {
                DispatchQueue.main.async {
                    self.stockInfo.text = "$\(stockLastPrice)"
                }
            }
        })
        
        
        
//        for stock in StockController.sharedController.stocksArray {
//            guard let stockSymbol = stock.symbol else {return}
//            
//            StockController.getStockInfo(stockSymbol, completion: { (stockInfo) in
//                guard let stockInfo = stockInfo else {return}
//                
//                if let stockLastPrice = stockInfo.lastPrice {
//                    DispatchQueue.main.async {
//                        self.stockInfo.text = "$\(stockLastPrice)"
//                    }
//                }
//            })
//        }
    }
}












//        for stock in StockController.sharedController.stocksArray {
//            StockController.getStockInfo(stock, completion: { (stockInfo) in
//                if let stockInfo = stockInfo {
//                    dispatch_async(dispatch_get_main_queue(), { 
//                			self.stockInfo.text = String(stockInfo.lastPrice)
//                    })
//                }
//            })
//        }


//StockController.getStockInfo(stock.name!) { (stockInfo) in
//    if let stockInfo = stockInfo {
//        dispatch_async(dispatch_get_main_queue(), {
//            self.stockInfo.text = String(stockInfo.lastPrice)
//        })
//    }
//}

//for stock in StockController.sharedController.stocksArray {
//    StockController.getStockInfo(stock.name!, completion: { (stockInfo) in
//        if let stockInfo = stockInfo {
//            dispatch_async(dispatch_get_main_queue(), {
//                self.stockInfo.text = String(stockInfo.lastPrice)
//            })
//        }
//    })
//}



