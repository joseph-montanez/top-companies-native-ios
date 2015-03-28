//
//  CompanyDetailTableViewController.swift
//  Top Companies
//
//  Created by Bernard Kohantob on 2/1/15.
//  Copyright (c) 2015 minidev. All rights reserved.
//

import UIKit

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
    @IBOutlet weak var overviewText: UILabel!
    
    // Business Information
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var revenue: UILabel!
    @IBOutlet weak var employees: UILabel!
    
    // Hidable Groups
    @IBOutlet weak var overviewCell: UITableViewCell!
    @IBOutlet weak var descriptionCell: UITableViewCell!
    @IBOutlet weak var businessInformationCell: UITableViewCell!
    
    
    
    override func viewDidLoad() {

    }
    
    //-- TODO: calculate height of each cell for dynamic text logic.
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var cellHeight : CGFloat = 40
        
        switch indexPath.row {
        case 0:
            cellHeight = 120
            break
        case 1:
            cellHeight = 124
            break
        case 2:
            let font = UIFont(name: "Helvetica Neue", size: 16)
            let screen = UIScreen.mainScreen()
            let width = screen.bounds.width - CGFloat(20.0) /* 20 margin */
            let constraintSize = CGSizeMake(width, CGFloat(MAXFLOAT))
            overviewText.sizeThatFits(constraintSize)
            overviewText.sizeToFit()
            let bounds = overviewText.bounds
            
            cellHeight = bounds.height
                + 20 /* Top Margin of Overview Title */
                + 24 /* Height of Overview Title */
                + 8 /* 8 margin */
            break
        case 3:
            let font = UIFont(name: "Helvetica Neue", size: 12)
            let screen = UIScreen.mainScreen()
            let width = screen.bounds.width - CGFloat(20.0) /* 20 margin */
            let constraintSize = CGSizeMake(width, CGFloat(MAXFLOAT))
            descriptionText.sizeThatFits(constraintSize)
            descriptionText.sizeToFit()
            let bounds = descriptionText.bounds
            
            cellHeight = bounds.height + 8 /* 8 margin */
            break
        case 4:
            cellHeight = 80
            break
        case 5:
            //-- TODO: auto hide year, rev, and employs, change height
            cellHeight = 160
            break
        default:
            cellHeight = 120
            break
        }
        println("Row \(indexPath.row) has height of \(cellHeight)")
        return cellHeight;
    }
}
