//
//  StockSerachViewController.swift
//  StockTrack
//
//  Created by Pierre on 7/11/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit

class StockSearchViewController: UIViewController {

    
    //MARK: Properties
    var stockSearchResults: [Lookup]?
    
    
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    
    //MARK: Further UI
    var searchControlelr: UISearchController!
    
    
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
    }
}

extension StockSearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockSearchResults?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("lookupCell", forIndexPath: indexPath) as! StockSearchTableViewCell
     
        if let stockSearchResults = stockSearchResults {
            let indexPath = stockSearchResults[indexPath.row]
            cell.updateCell(indexPath)
        }
        return cell
    }
}


extension StockSearchViewController: UISearchResultsUpdating {
    
    func setupSearchController() {
        searchControlelr = UISearchController(searchResultsController: nil)
        searchControlelr.searchResultsUpdater = self
        
        tableView.tableHeaderView = searchControlelr.searchBar
        
        definesPresentationContext = true
    }
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchTerm = searchControlelr.searchBar.text?.lowercaseString
        
        if let searchTerm = searchTerm {
            StockController.lookupStock(searchTerm, completion: { (stockArray) in
                if let stockArray = stockArray {
                    self.stockSearchResults = stockArray
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        self.tableView.reloadData()
                    })
                }
            })
        }
    }
}

