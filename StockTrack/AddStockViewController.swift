//
//  AddStockViewController.swift
//  StockTrack
//
//  Created by Pierre on 7/5/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit

class AddStockViewController: UIViewController {

    
    var stock: Stock?
    
    //MARK: IBOutlets
    @IBOutlet weak var stockLabel: UITextField!
    
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    //MARK: IBActions
    @IBAction func addButtonTapped(sender: AnyObject) {
        if let text = stockLabel.text {
                StockController.searchStockForInformation(text, completion: { (stock) in
                    guard let stock = stock else {return}
                    
                    StockController.sharedController.addStock(stock)
                })
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
}
