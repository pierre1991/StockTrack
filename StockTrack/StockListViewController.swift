//
//  StockListViewController.swift
//  StockTrack
//
//  Created by Pierre on 7/5/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import UIKit

class StockListViewController: UIViewController {
    
    
    var stocks: Stock?
    var stock: [Stock] = {
        StockController.sharedController.stocksArray
    }()
    
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: View Life Cyce
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
			self.animateTable()
        }
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    func setupNavigationBar() {
        navigationItem.title = "StockTrack"
        navigationController?.navigationBar.isTranslucent = false
    }

}



extension StockListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StockController.sharedController.stocksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell", for: indexPath) as! StockTableViewCell
        let stockPath = StockController.sharedController.stocksArray[(indexPath as NSIndexPath).row]
        
        cell.updateCell(stockPath)
    	cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            StockController.sharedController.stocksArray.remove(at: (indexPath as NSIndexPath).row)
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
