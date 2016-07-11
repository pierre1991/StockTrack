//
//  StockSearchTableViewCell.swift
//  StockTrack
//
//  Created by Pierre on 7/11/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit


protocol StockSearchTableViewCellDelegate: class {
    func addStockToList(sender: StockTableViewCell)
}



class StockSearchTableViewCell: UITableViewCell {

    
    //MARK: Delegate
    weak var stockSearchTableViewDelegate: StockSearchTableViewCellDelegate?
    
    
    //MARK: IBOutlets
    @IBOutlet weak var stockName: UILabel!
    
    
    
    //MARK: View
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    
    //MARK: IBAction
    @IBAction func addStockButtonTapped(sender: AnyObject) {

    }
    
    
    //MARK: Update
    func updateCell(stock: Stock) {
    	stockName.text = stock.name
    }
    
}
