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
        
        tableView.tableFooterView = UIView()
        setupSearchController()
    }

    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }    
}



extension StockSearchViewController: UISearchResultsUpdating, UISearchBarDelegate {

    func setupSearchController() {
		searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.delegate = self
        
        searchController.searchBar.keyboardAppearance = .dark
        searchController.searchBar.barTintColor = UIColor.darkBlueColor()
        
        
    	providesPresentationContextTransitionStyle = true
        
        tableView.tableHeaderView = searchController.searchBar
	}
    
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchTerm = searchController.searchBar.text?.lowercased()
        
        if let searchTerm = searchTerm {
			StockController.lookupStock(searchTerm, completion: { (stockArray) in
                if let stockArray = stockArray {
                    self.stockSearchResults = stockArray
                    
                    DispatchQueue.main.async {
						self.tableView.reloadData()
                    }
                }
            })
        }
    }

    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    }
}



extension StockSearchViewController: UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stockSearchResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lookupCell", for: indexPath) as! StockSearchTableViewCell
        
        if let stockSearchResults = stockSearchResults {
            let indexPath = stockSearchResults[(indexPath as NSIndexPath).row]
            
            cell.updateCell(indexPath)
            cell.selectionStyle = .none
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let stockSearchResults = stockSearchResults {
            let selectedItem = stockSearchResults[(indexPath as NSIndexPath).row]
            
            StockController.sharedController.addStock(selectedItem)
        }
        
        dismiss(animated: true) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
