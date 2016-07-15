//
//  NetworkController.swift
//  StockTrack
//
//  Created by Pierre on 7/5/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class NetworkController {
    

    static let lookupBaseUrl = "http://dev.markitondemand.com/MODApis/Api/v2/Lookup/json?input="
    static let quoteBaseUrl = "http://dev.markitondemand.com/MODApis/Api/v2/Quote/json?symbol="
    
    
    static func lookupStock(stock: String) -> NSURL? {
        return NSURL(string: NetworkController.lookupBaseUrl + "\(stock)")!
    }
    
	static func searchStockForInfo(stock: String) -> NSURL? {
        return NSURL(string: NetworkController.quoteBaseUrl + "\(stock)") ?? nil
    }
    
    
    static func dataAtUrl(url: NSURL, completion:(data: NSData?) -> Void) {
        let session = NSURLSession.sharedSession()
        
        let dataTask = session.dataTaskWithURL(url) { (data, _, error) -> Void in
            guard let data = data else {
                print(error?.localizedDescription)
                completion(data: nil)
                return
            }
            completion(data: data)
        }
        dataTask.resume()
    }
}