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
    
    
    static func dataAtUrl(_ url: URL, completion:@escaping (_ data: Data?) -> Void) {
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url, completionHandler: { (data, _, error) -> Void in
            guard let data = data else {
                print(error?.localizedDescription ?? "no data at url")
                completion(nil)
                return
            }
            completion(data)
        })
        dataTask.resume()
    }

    
    static func lookupStock(_ keyword: String) -> URL? {
    	return URL(string: lookupBaseUrl + "\(keyword)")
    }
    
    static func searchStockForInfo(_ stock: String) -> URL? {
        return URL(string: quoteBaseUrl + "\(stock)")
    }
    
}
