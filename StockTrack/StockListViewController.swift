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
    
    
    
    //MARK: FurtherUI
    
    
    
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
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
}



extension StockListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StockController.sharedController.stocksArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("stockCell", forIndexPath: indexPath) as! StockTableViewCell
        let indexPath = StockController.sharedController.stocksArray[indexPath.row]
        
        cell.updateCell(indexPath)
    	cell.selectionStyle = .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            StockController.sharedController.stocksArray.removeAtIndex(indexPath.row)
            StockController.sharedController.saveToPersistantStorage()
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}
