//
//  CompanyDetailTableViewController.swift
//  Top Companies
//
//  Created by Bernard Kohantob on 2/1/15.
//  Copyright (c) 2015 minidev. All rights reserved.
//

import UIKit
import Dollar

class CompanyDetailTableViewController: UITableViewController {
    // Banner Image
    @IBOutlet weak var bannerImage: UIImageView!
    
    // Basic Company Information
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var cityStateZip: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    // Descrition
    @IBOutlet weak var descriptionText: UILabel!
    
    // Overview
    @IBOutlet weak var overviewTitleText: UILabel!
    @IBOutlet weak var overviewText: UILabel!
    
    // Business Information
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var revenue: UILabel!
    @IBOutlet weak var employees: UILabel!
    
    // Hidable Groups
    @IBOutlet weak var overviewTitleCell: UITableViewCell!
    @IBOutlet weak var overviewCell: UITableViewCell!
    @IBOutlet weak var descriptionCell: UITableViewCell!
    @IBOutlet weak var businessInformationCell: UITableViewCell!
    
    var company: TPCompany?
    
    override func viewDidLoad() {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 0
    }
    
    func setCompany(company: TPCompany) {
        self.company = company
        
        tableView.beginUpdates()
        
        self.companyName.text = company.name
        self.address.text = company.address
        self.cityStateZip.text = company.city
        self.website.text = company.website
        self.phone.text = company.phone
        
        self.overviewText.text = company.description
        if countElements(company.description) == 0 {
            overviewTitleCell.hidden = true
            overviewCell.hidden = true
            
            overviewTitleCell.contentView.hidden = true
            overviewCell.contentView.hidden = true

        } else {
            overviewTitleCell.hidden = false
            overviewCell.hidden = false
            
            overviewTitleCell.contentView.hidden = false
            overviewCell.contentView.hidden = false
            
            //overviewTitleCell.
        }
        self.descriptionText.text = company.descriptionMeta
        if countElements(company.descriptionMeta) == 0 {
            descriptionCell.hidden = true
        } else {
            descriptionCell.hidden = false
        }
        
        tableView.reloadData()
        tableView.endUpdates()
    }
    
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = super.tableView.cellForRowAtIndexPath(indexPath)
//        
//    }
    
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath)
//        if cell.hidden == true {
//            return 0.0
//        } else {
//            return super.tableView(tableView, heightForRowAtIndexPath: indexPath)
//        }
//    }

    
//    
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        
//        var total = 0
//        
//        for index in 0...5 {
//            let indexPath = NSIndexPath(forRow: index, inSection: 0)
//            let cell = tableView.cellForRowAtIndexPath(indexPath)
//        }
//        
//        let indexPaths = (0...5).map {
//            NSIndexPath(forRow: $0, inSection: 0)
//        }
////        let cells = indexPaths.map{ indexPath in
////            tableView.cellForRowAtIndexPath(indexPath)
////        }
//        
////        let visibleAmount = $.reduce(cells, initial: 0) { (total, cell) in
////            switch cell?.hidden {
////            case .Some(true):
////                return total
////            case _:
////                return total + 1
////            }
////        }
//        
//        return 4
//    }
    
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 0;
//    }
    
    //-- TODO: calculate height of each cell for dynamic text logic.
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        var cellHeight : CGFloat = 40
//        
//        switch indexPath.row {
//        case 0:
//            cellHeight = 120
//            break
//        case 1:
//            cellHeight = 124
//            break
//        case 2:
//            let font = UIFont(name: "Helvetica Neue", size: 16)
//            let screen = UIScreen.mainScreen()
//            let width = screen.bounds.width - CGFloat(20.0) /* 20 margin */
//            let constraintSize = CGSizeMake(width, CGFloat(MAXFLOAT))
//            overviewText.sizeThatFits(constraintSize)
//            overviewText.sizeToFit()
//            let bounds = overviewText.bounds
//            
//            cellHeight = bounds.height
//                + 20 /* Top Margin of Overview Title */
//                + 24 /* Height of Overview Title */
//                + 8 /* 8 margin */
//            break
//        case 3:
//            let font = UIFont(name: "Helvetica Neue", size: 12)
//            let screen = UIScreen.mainScreen()
//            let width = screen.bounds.width - CGFloat(20.0) /* 20 margin */
//            let constraintSize = CGSizeMake(width, CGFloat(MAXFLOAT))
//            descriptionText.sizeThatFits(constraintSize)
//            descriptionText.sizeToFit()
//            let bounds = descriptionText.bounds
//            
//            cellHeight = bounds.height + 8 /* 8 margin */
//            break
//        case 4:
//            cellHeight = 80
//            break
//        case 5:
//            //-- TODO: auto hide year, rev, and employs, change height
//            cellHeight = 160
//            break
//        default:
//            cellHeight = 120
//            break
//        }
//        println("Row \(indexPath.row) has height of \(cellHeight)")
//        return cellHeight;
//    }
}
