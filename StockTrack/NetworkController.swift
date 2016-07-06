//
//  NetworkController.swift
//  StockTrack
//
//  Created by Pierre on 7/5/16.
//  Copyright © 2016 Pierre. All rights reserved.
//

import Foundation

class NetworkController {
    
    static let baseUrl = "http://dev.markitondemand.com/MODApis/Api/v2/Quote/json?symbol="
    
    static func searchStockQuote(symbol: String) -> NSURL? {
        return NSURL(string: NetworkController.baseUrl + "\(symbol)")!
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