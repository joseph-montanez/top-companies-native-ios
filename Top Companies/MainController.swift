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
    var results: [TPSearchItem] = []
    @IBOutlet var tableView: UITableView!
    @IBOutlet var loader: UIActivityIndicatorView!
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
    
    func getStoryBoard() -> UIStoryboard {
        return self.storyboard!
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
}