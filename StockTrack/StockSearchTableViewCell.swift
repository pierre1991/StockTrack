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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    func updateCell(stock: Lookup) {
    	stockName.text = stock.name
    }
    
}
