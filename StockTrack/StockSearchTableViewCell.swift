//
//  StockSearchTableViewCell.swift
//  StockTrack
//
//  Created by Pierre on 7/11/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit

class StockSearchTableViewCell: UITableViewCell {

    
    //MARK: IBOutlets
    @IBOutlet weak var stockName: UILabel!
    
    
    
    //MARK: View
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    
    //MARK: Update
    func updateCell(stock: Stock) {
    	stockName.text = stock.name
    }
}
