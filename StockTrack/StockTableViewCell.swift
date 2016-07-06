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
