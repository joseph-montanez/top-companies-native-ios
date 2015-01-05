//
//  ListController.swift
//  Top Companies
//
//  Created by Bernard Kohantob on 12/22/14.
//  Copyright (c) 2014 minidev. All rights reserved.
//

import UIKit

class ListController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    var simpleTableIdentifier: String = "companyItemCell"
    var categoryId : String = ""
    var results: [TPCompany] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("Loaded! with category \(categoryId)")
    }
    
    @IBAction func goBack(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Table View Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(tableView2: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCellWithIdentifier(simpleTableIdentifier) as UITableViewCell
        var label: UILabel;
        //        if cell == nil {
        //            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: simpleTableIdentifier)
        //        }
        label = cell.contentView.viewWithTag(10) as UILabel;
        //        cell.textLabel.text = keywordList[indexPath.row]
        label.text = results[indexPath.row].name
        
        
        //cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("Selected row! - \(indexPath.row)")
        
        let item = self.results[indexPath.row]
        switch item.type {
        case .Category:
            let listController = getStoryBoard().instantiateViewControllerWithIdentifier("ListController") as ListController
            listController.categoryId = item.id
            self.presentViewController(listController, animated: true, completion: nil)
        case .Company:
            println("TODO: implement go to company")
        }
    }
}