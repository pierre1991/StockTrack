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
    var stockSearchResults: [Stock]?
    
    //Further UI
    var customSearchBar: CustomSearchBar!
    var searchController: UISearchController!
    
    
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    

	//MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchController()
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }    
}



extension StockSearchViewController: UISearchResultsUpdating, UISearchBarDelegate {

    func setupSearchController() {
		searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.delegate = self
        
        searchController.searchBar.keyboardAppearance = .Dark
        searchController.searchBar.barTintColor = UIColor.darkBlueColor()
        
        
    	providesPresentationContextTransitionStyle = true
        
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
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
    }
    


}



extension StockSearchViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockSearchResults?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("lookupCell", forIndexPath: indexPath) as! StockSearchTableViewCell
        
        if let stockSearchResults = stockSearchResults {
            let indexPath = stockSearchResults[indexPath.row]
            
            cell.updateCell(indexPath)
            cell.selectionStyle = .None
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let stockSearchResults = stockSearchResults {
            let selectedItem = stockSearchResults[indexPath.row]
            
            StockController.sharedController.addStock(selectedItem)
        }
        
        dismissViewControllerAnimated(true) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        searchController.searchBar.resignFirstResponder()
    }
    
    
    
    
    
    
    
//    //MARK: Helper Functions
//    func animateTable() {
//        self.tableView.reloadData()
//        
//        let cells = tableView.visibleCells
//        let tableHeight: CGFloat = tableView.bounds.size.height
//        
//        for i in cells {
//            let cell: UITableViewCell = i as UITableViewCell
//            cell.transform = CGAffineTransformMakeTranslation(0, tableHeight)
//        }
//        
//        var index = 0
//        
//        for a in cells {
//            let cell: UITableViewCell = a as UITableViewCell
//            
//            UIView.animateWithDuration(1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
//                cell.transform = CGAffineTransformMakeTranslation(0, 0)
//                }, completion: nil)
//            index += 1
//        }
//    }
}