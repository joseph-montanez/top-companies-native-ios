//
//  CompanyDetailViewController.swift
//  Top Companies
//
//  Created by Bernard Kohantob on 2/1/15.
//  Copyright (c) 2015 minidev. All rights reserved.
//

import UIKit
import PromiseKit

class CompanyDetailViewController: UIViewController {
    
    @IBOutlet weak var subHeader: UILabel!
    
    var company: TPCompany?
    var companyOverride: Promise<TPCompany>?
    var tableViewController: CompanyDetailTableViewController?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "CompanyDetailSegue") {
            self.tableViewController = segue.destinationViewController as? CompanyDetailTableViewController
        }
    }
    
    func setCompany(companyOpt: TPCompany?) {
        println("setCompany")
        if let company = companyOpt {
            println("company has details")
            self.company = company
            if let controller = self.tableViewController {
                controller.descriptionText.text = "Hello World"
                println("Loaded company data")
                
            } else {
                println("table view controller not ready yet!")
            }
        } else {
            println("company is nil")
        }
        
    }
    
    @IBAction func goBack(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
