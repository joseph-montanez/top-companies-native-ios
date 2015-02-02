//
//  ViewController.swift
//  Top Companies
//
//  Created by Joseph Montanez on 8/8/14.
//  Copyright (c) 2014 Comentum Corp. All rights reserved.
//

import UIKit

class MainController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    var simpleTableIdentifier: String = "SearchItemCell"
    var selectedIndex: Int = 0
    var results: [TPSearchItem] = []
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loader: UIActivityIndicatorView!
    @IBOutlet weak var searchfield: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(animated: Bool) {
        if let selectedPath = tableView.indexPathForSelectedRow() {
            tableView.deselectRowAtIndexPath(selectedPath, animated: false)
        }
    }
    
    @IBAction func unwindToSearch(segue: UIStoryboardSegue) {
        
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
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //-- Why do I have to write this in code??!?!?!??!
        if (tableView.respondsToSelector(Selector("setSeparatorInset:"))) {
            tableView.separatorInset = UIEdgeInsetsZero
        }
        if (tableView.respondsToSelector(Selector("setLayoutMargins:"))) {
            tableView.layoutMargins = UIEdgeInsetsZero
        }
        if (cell.respondsToSelector(Selector("setLayoutMargins:"))) {
            cell.layoutMargins = UIEdgeInsetsZero
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(tableView2: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCellWithIdentifier(simpleTableIdentifier) as? KeywordTableViewCell {
            return self.loadDataToCell(cell, item: results[indexPath.row])
        } else {
            let cell = KeywordTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: simpleTableIdentifier)
            return self.loadDataToCell(cell, item: results[indexPath.row])
        }
    }
    
    func loadDataToCell(cell: KeywordTableViewCell, item: TPSearchItem) -> KeywordTableViewCell {
        cell.loadItem(title: item.name)
        
        return cell
    }
    
    func getStoryBoard() -> UIStoryboard {
        return self.storyboard!
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("Selected row! - \(indexPath.row)")
        
        let item = self.results[indexPath.row]
        selectedIndex = indexPath.row
        
        switch item.type {
        case .Category:
            println("Go to company listing view")
            performSegueWithIdentifier("showCategoryListing", sender: self)
            break
        case .Company:
            println("Go to company details view")
            performSegueWithIdentifier("jumpToCompanyDetails", sender: self)
            break
        }
    }
    
    func getKeywords(value: NSString) {
        //-- Show loading
        self.loader.hidden = false
        
        let search = Api().search(value)
        search.then { (items:[TPSearchItem]) -> Void in
            self.results = items
            self.loader.hidden = true
            self.tableView.hidden = false
            self.tableView.reloadData()
        }
        search.catch { error in
            self.loader.hidden = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let name = segue.identifier
        if (name == "showCategoryListing") {
            let controller = segue.destinationViewController as ListController
            controller.promise = Api().listing(results[selectedIndex].id)
            controller.categoryId = results[selectedIndex].id.toInt()!
        } else if (name == "jumpToCompanyDetails") {
            let controller = segue.destinationViewController as CompanyDetailViewController
            
        }
    }
}