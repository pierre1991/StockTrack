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
    @IBOutlet weak var noStocksView: UIView!
    
    
    //MARK: View Life Cyce
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
        
        setupNavigationBar()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
		tableView.reloadData()
    }
    
    
    //MARK: Status Bar
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    
    //MARK: View Setup
    func setupNavigationBar() {
        navigationItem.title = "StockLook"
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    func setupTableView() {
        tableView.tableFooterView = UIView()
    }
    
    
    
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as? StockDetailViewController
        
        if segue.identifier == "toStockDetailView" {
           	guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let stock = StockController.sharedController.stocksArray[indexPath.row]
            
            destinationViewController?.stock = stock
        }
    }

}



extension StockListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if StockController.sharedController.stocksArray.count == 0 {
            self.noStocksView.isHidden = false
        } else if StockController.sharedController.stocksArray.count > 0 {
            self.noStocksView.isHidden = true 
        	return StockController.sharedController.stocksArray.count
        }
        
        return StockController.sharedController.stocksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as! StockTableViewCell
        let stockPath = StockController.sharedController.stocksArray[indexPath.row]
        
        cell.updateCell(stockPath)
    	cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            StockController.sharedController.stocksArray.remove(at: indexPath.row)
            StockController.sharedController.saveToPersistantStorage()
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        }
    }
    
    

    
    
    
    //MARK: Helper Functions
    func animateTable() {
        self.tableView.reloadData()
        
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        
        for i in cells {
            let cell: UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight)
        }
        
        var index = 0
        
        for a in cells {
            let cell: UITableViewCell = a as UITableViewCell
            
            UIView.animate(withDuration: 1.0, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
                }, completion: nil)
            
            index += 1
        }
    }
}
