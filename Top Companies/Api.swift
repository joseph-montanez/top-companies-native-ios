//
//  Api.swift
//  Top Companies
//
//  Created by Joseph Montanez on 12/23/14.
//  Copyright (c) 2014 Comentum Corp. All rights reserved.
//

import Foundation
import PromiseKit
import Dollar

class Api {
    let endPoint = "http://hawk2.comentum.com/topcompanies/app-api"

    func parseJson(jsonData: NSData) -> NSArray {
        var error: NSError?
        let jsonDict = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as NSArray
        return jsonDict
    }
    
    func search(value: String) -> Promise<[TPSearchItem]> {
        let searchEndPoint = "\(endPoint)/related-keywords.php"
        let params = ["term":value];
        let promise = Promise<[TPSearchItem]> { fulfiller, rejecter in
            let request:Promise<NSArray> = NSURLConnection.GET(searchEndPoint, query: params)
            request.then { (jsonResults:NSArray) -> Void in
                let rows = jsonResults as [NSDictionary]
                let items = $.reduce(rows, initial: [TPSearchItem]()) { (collection, dict) in
                    if let item = TPSearchItem(label: dict["label"] as String, value: dict["value"] as String) {
                        return collection + [item]
                    } else {
                        return collection
                    }
                }
                fulfiller(items)
            }
            request.catch { (error:NSError) -> Void in
                rejecter(error)
            }
        }
        
        
        
        return promise
    }
}