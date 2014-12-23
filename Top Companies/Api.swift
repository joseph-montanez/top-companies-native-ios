//
//  Api.swift
//  Top Companies
//
//  Created by Joseph Montanez on 12/23/14.
//  Copyright (c) 2014 Comentum Corp. All rights reserved.
//

import Foundation

class Api {
    let endPoint = "http://hawk2.comentum.com/topcompanies/app-api"

    func parseJson(jsonData: NSData) -> NSArray {
        var error: NSError?
        let jsonDict = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as NSArray
        return jsonDict
    }
    
    func search(value: String) -> Future<[TPSearchItem]> {
        let promise = Promise<[TPSearchItem]>()
        
        Queue.global.async {
            let term = value.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
            var results = [TPSearchItem]()
            
            let apiUrl = "\(self.endPoint)/related-keywords.php?term=\(term)"
            println("calling: \(apiUrl)")
            
            if let url = NSURL(string: apiUrl) {
                let request = NSURLRequest(URL: url)
                
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
                    if (data != nil) {
                        let jsonResults = self.parseJson(data)
                        let jsonPayload = NSString(data: data, encoding: NSUTF8StringEncoding)
                        println(jsonPayload)
                        
                        if jsonResults.count > 0 {
                            for row in jsonResults {
                                let dict = row as NSDictionary
                                if let item = TPSearchItem(label: dict["label"] as String, value: dict["value"] as String) {
                                    results.append(item)
                                }
                            }
                        }
                        
                        promise.success(results)
                    } else {
                        promise.error(error)
                    }
                }
            } else {
                promise.error(NSError(domain: "Failed to apply term", code: 1, userInfo: nil))
            }
        }
        
        return promise.future
    }
}