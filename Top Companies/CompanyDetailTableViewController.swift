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
    
    override func viewDidLoad() {

    }
    
    //-- TODO: calculate height of each cell for dynamic text logic.
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //-[NSString sizeWithFont:constrainedToSize:]
//        CGSize size = [string sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:17.0f]}];
//        
//        // Values are fractional -- you should take the ceilf to get equivalent values
//        CGSize adjustedSize = CGSizeMake(ceilf(size.width), ceilf(size.height));
        
//        tableView.r
//        NSString *str = [dataSourceArray objectAtIndex:indexPath.row];
//        CGSize size = [str sizeWithFont:[UIFont fontWithName:@"Helvetica Nue" size:17] constrainedToSize:CGSizeMake(300, 999) lineBreakMode:NSLineBreakByWordWrapping];
//        NSLog(@"%f",size.height);
//        return size.height + 10;
//        return CGFloat(44.0)
        //BannerImageCell
        //CompanyInfo
        //CompanyOverview
        if let cell = self.tableView.cellForRowAtIndexPath(indexPath) {
            if let id = cell.reuseIdentifier {
                switch id {
                case "BannerImageCell":
                    return 120
                case "CompanyInfo":
                    return 124
                case "CompanyOverview":
                    //-- TODO: dynamic cell calculation
                    return UITableViewAutomaticDimension
                default:
                    return UITableViewAutomaticDimension
                }
                
            } else {
                return UITableViewAutomaticDimension
            }
        } else {
            return UITableViewAutomaticDimension
        }
    }
}
