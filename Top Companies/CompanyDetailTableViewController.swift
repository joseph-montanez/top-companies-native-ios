//
//  CompanyDetailTableViewController.swift
//  Top Companies
//
//  Created by Bernard Kohantob on 2/1/15.
//  Copyright (c) 2015 minidev. All rights reserved.
//

import UIKit

class CompanyDetailTableViewController: UITableViewController {
    @IBOutlet weak var bannerImage: UIImageView!
    @IBOutlet weak var overviewText: UILabel!
    
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
            break
        default:
            cellHeight = 120
            break
        }
        println("Row \(indexPath.row) has height of \(cellHeight)")
        return cellHeight;
    }
}