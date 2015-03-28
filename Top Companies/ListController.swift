//
//  ListController.swift
//  Top Companies
//
//  Created by Joseph Montanez on 12/22/14.
//  Copyright (c) 2014 Comentum Corp. All rights reserved.
//

import UIKit
import PromiseKit

class ListController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    var simpleTableIdentifier: String = "CompanyItemCell"
    var categoryId : Int = 0
    var promise: Promise<[TPCompany]>?
    var results: [TPCompany] = []
    var selectedCompany: TPCompany?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("Loaded! with category \(categoryId)")
    }
    
    override func viewDidAppear(animated: Bool) {
        promise?.then { (companies: [TPCompany]) -> Void in
            println("Request finished")
            self.results = companies
            self.tableView.reloadData()
        }
    }
    
    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        
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
        if let cell = self.tableView.dequeueReusableCellWithIdentifier(simpleTableIdentifier) as? CompanyTableViewCell {
            return self.loadDataToCell(cell, company: results[indexPath.row])
        } else {
            let cell = CompanyTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: simpleTableIdentifier)
            return self.loadDataToCell(cell, company: results[indexPath.row])
        }
    }
    
    func loadDataToCell(cell: CompanyTableViewCell, company: TPCompany) -> CompanyTableViewCell {
        cell.name.text = company.name
        cell.address.text = company.address
        cell.cityStateZip.text = "\(company.city) \(company.city) \(company.zip)"
        cell.website.text = company.website
        cell.phone.text = company.phone
        
        return cell
    }
    
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        println("Selected row! - \(indexPath.row)")
        self.selectedCompany = self.results[indexPath.row]
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showCompanyDetails") {
            var detailController = segue.destinationViewController as CompanyDetailViewController
            detailController.company = self.selectedCompany
            
            if let row = self.tableView.indexPathForSelectedRow()?.row {
                let company = self.results[row];
                let promise = Api().detail(company.id)
                
                // API is good, pass to set func to populate
                promise.then { (companyFullDetail:TPCompany) -> Void in
                    detailController.setCompany(companyFullDetail)
                }
                // API failed, let fall back with the data that we have
                promise.catch { error in
                    detailController.setCompany(nil)
                }
            } else {
                println("ListController: there is no selected company")
            }
            
        }
    }
}