//
//  StockListViewController.swift
//  StockTrack
//
//  Created by Pierre on 7/5/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit

class StockListViewController: UIViewController {

    
	
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    
    //MARK: View Life Cyce
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        dispatch_async(dispatch_get_main_queue()) { 
            self.tableView.reloadData()
        }
    }
}



extension StockListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if StockController.sharedController.stocks.count > 0 {
            return StockController.sharedController.stocks.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("stockCell", forIndexPath: indexPath) as! StockTableViewCell
        let indexPath = StockController.sharedController.stocks[indexPath.row]
        
        cell.updateCell(indexPath)
    	cell.selectionStyle = .None
        
        return cell
    }
}
