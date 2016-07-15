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

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
    func updateCell(stock: Stock) {
        self.stockName.text = stock.name

	
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



