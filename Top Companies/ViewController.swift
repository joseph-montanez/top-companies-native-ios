//
//  ViewController.swift
//  Top Companies
//
//  Created by minidev on 8/8/14.
//  Copyright (c) 2014 minidev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var simpleTableIdentifier: String = "cell"
    var shoppingList: [String] = ["Eggs", "Milk"]
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onSearchEdit(sender: UITextField, forEvent event: UIEvent) {
        println("Edited \(sender.text)")
        if countElements(sender.text!) > 2 {
            getKeywords(sender.text)
        }
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: simpleTableIdentifier)
        cell.textLabel.text = shoppingList[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("Selected row! - \(indexPath.row)")
    }
    
    func getKeywords(value: NSString) {
        let url = NSURL(string: "http://hawk2.comentum.com/topcompanies/app-api/related-keywords.php?term=\(value.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet()))")
        let request = NSURLRequest(URL: url)
        // TODO show loader
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            let jsonPayload = NSString(data: data, encoding: NSUTF8StringEncoding)
            println(jsonPayload)
            // TODO hide loader
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

