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
    var stockList = {
        StockController.sharedController.stocksArray
    }
    
    var stockSearchResults: [Lookup]?
    
    
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    
    //MARK: Further UI
    var searchBar: UISearchBar!
    var searchController: UISearchController!
    
    
    
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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let selectedItem = 
        
        
        dismissViewControllerAnimated(true, completion: nil)
    }
}


extension StockSearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    
    func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.delegate = self
        searchController.searchBar.keyboardAppearance = .Dark
        
        
        tableView.tableHeaderView = searchController.searchBar
	}
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let searchTerm = searchController.searchBar.text?.lowercaseString
        
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

    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}



