//
//  ViewController.swift
//  Top Companies
//
//  Created by minidev on 8/8/14.
//  Copyright (c) 2014 minidev. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var simpleTableIdentifier: String = "cell"
    var keywordList: [String] = []
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loader: UIActivityIndicatorView!
    @IBOutlet weak var scoller: UIScrollView!
    @IBOutlet weak var searchfield: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: simpleTableIdentifier)
        //let tapRec = UITapGestureRecognizer(target: self, action: "tap")
        //self.view.addGestureRecognizer(tapRec)
        self.searchfield.delegate = self
    }
    
    @IBAction func dismissKeyboardOnTap(sender: UITextField) {
        self.view.endEditing(true)
    }

    @IBAction func onSearchEdit(sender: UITextField, forEvent event: UIEvent) {
        println("Edited \(sender.text)")
        if countElements(sender.text!) > 2 {
            getKeywords(sender.text)
        } else {
            self.tableView.hidden = true
            self.loader.hidden = true
        }
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        return keywordList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: simpleTableIdentifier)
        cell.textLabel.text = keywordList[indexPath.row]
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("Selected row! - \(indexPath.row)")
    }
    
    func getKeywords(value: NSString) {
        let url = NSURL(string: "http://hawk2.comentum.com/topcompanies/app-api/related-keywords.php?term=\(value.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet()))")
        let request = NSURLRequest(URL: url)
        // TODO show loader
        self.loader.hidden = false
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
            let rows = self.parseJson(data)
            let jsonPayload = NSString(data: data, encoding: NSUTF8StringEncoding)
            println(jsonPayload)
            
            self.keywordList = []
            if rows.count > 0 {
                for row in rows {
                    let item = row as NSDictionary
                    self.keywordList.append(item["label"] as String)
                }
            }
            
            self.loader.hidden = true
            self.tableView.hidden = false
            self.tableView.reloadData()
        }
    }
    
    func parseJson(jsonData: NSData) -> NSArray {
        var error: NSError?
        let jsonDict = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &error) as NSArray
        return jsonDict
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}