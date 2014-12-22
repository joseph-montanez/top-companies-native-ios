//
//  ViewController.swift
//  Top Companies
//
//  Created by minidev on 8/8/14.
//  Copyright (c) 2014 minidev. All rights reserved.
//

import UIKit

class KeywordTableViewCell : UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    
    func loadItem(#title: String) {
        titleLabel.text = title
    }
}

class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var simpleTableIdentifier: String = "keywordCell"
    var keywordList: [String] = []
    var results: NSArray = []
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loader: UIActivityIndicatorView!
    @IBOutlet weak var scoller: UIScrollView!
    @IBOutlet weak var searchfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let tapRec = UITapGestureRecognizer(target: self, action: "tap")
        //self.view.addGestureRecognizer(tapRec)
        self.searchfield.delegate = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: simpleTableIdentifier)
        var nib = UINib(nibName: "KeywordTableViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "keywordCell")
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keywordList.count
    }
    
    func tableView(tableView2: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier(simpleTableIdentifier) as UITableViewCell
        var label: UILabel;
//        if cell == nil {
//            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: simpleTableIdentifier)
//        }
        label = cell.contentView.viewWithTag(10) as UILabel;
//        cell.textLabel.text = keywordList[indexPath.row]
        label.text = keywordList[indexPath.row]

        
        //cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    func getStoryBoard() -> UIStoryboard {
        return self.storyboard!
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("Selected row! - \(indexPath.row)")
        
        let item = self.results[indexPath.row] as NSDictionary
        let value = item["value"] as String
        let parts = value.componentsSeparatedByString("_")
        if (parts.count == 2) {
            let valueType = parts[0]
            
            if (valueType == "company") {
                // TODO:
                let companyId = parts[1]
                // Go to company detail view
            } else {
                let categoryId = parts[1]
                let listController = getStoryBoard().instantiateViewControllerWithIdentifier("ListController") as ListController
                listController.categoryId = categoryId
                self.presentViewController(listController, animated: true, completion: nil)
            }
            
        }
    }
    
    func getKeywords(value: NSString) {
        let term = value.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())!
        if let url = NSURL(string: "http://hawk2.comentum.com/topcompanies/app-api/related-keywords.php?term=\(term)") {
            let request = NSURLRequest(URL: url)
            // TODO show loader
            self.loader.hidden = false
            
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
                self.results = self.parseJson(data)
                let jsonPayload = NSString(data: data, encoding: NSUTF8StringEncoding)
                println(jsonPayload)
                
                self.keywordList = []
                if self.results.count > 0 {
                    for row in self.results {
                        let item = row as NSDictionary
                        self.keywordList.append(item["label"] as String)
                    }
                }
                
                self.loader.hidden = true
                self.tableView.hidden = false
                self.tableView.reloadData()
            }
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