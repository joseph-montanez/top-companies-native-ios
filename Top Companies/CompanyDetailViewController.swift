//
//  CompanyDetailViewController.swift
//  Top Companies
//
//  Created by Bernard Kohantob on 2/1/15.
//  Copyright (c) 2015 minidev. All rights reserved.
//

import UIKit
import CoreFoundation
import PromiseKit

class CompanyDetailViewController: UIViewController {
    
    @IBOutlet weak var subHeader: UILabel!
    
    var subHeaderTitle: String?
    var company: TPCompany?
    var companyOverride: Promise<TPCompany>?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContrainerView: UIView!
    @IBOutlet weak var scrollContainerViewHeight: NSLayoutConstraint!
    
    // Banner Image
    @IBOutlet weak var bannerImage: UIImageView!
    
    // Basic Company Information
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var cityStateZip: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    // Overview
    @IBOutlet weak var overviewTitleText: UILabel!
    @IBOutlet weak var overviewTitleTextTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var overviewTitleTextBetweenConstraint: NSLayoutConstraint!
    @IBOutlet weak var overviewTitleTextHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var overviewText: UILabel!
    @IBOutlet weak var overviewTextBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var overviewTextHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var noOfEmployees: UILabel!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let title = subHeaderTitle {
            subHeader?.text = title
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setCompany(companyOpt: TPCompany?) {
        company = companyOpt
        if let company = companyOpt {
            println("company has details")
            //-- TODO Randomize Banner
                
            self.companyName.text = company.name
            self.address.text = company.address
            self.cityStateZip.text = company.city
            self.website.text = company.website
            self.phone.text = company.phone
            
            self.overviewText.text = company.description
            
            if countElements(company.description) == 0 {
                //            overviewTitleCell.hidden = true
                overviewTitleText.text = ""
                overviewTitleTextTopConstraint.constant = 0
                overviewTitleTextBetweenConstraint.constant = 0
                overviewTitleTextHeightConstraint.constant = 0
                overviewTitleTextHeightConstraint.priority = 750
                
                
                //            overviewCell.hidden = true
                overviewTextBottomConstraint.constant = 0
                overviewTextHeightConstraint.constant = 0
                overviewTextHeightConstraint.priority = 750
            } else {
//                overviewTitleCell.hidden = false
                overviewTitleText.text = "Overview"
                overviewTitleTextTopConstraint.constant = 15
                overviewTitleTextBetweenConstraint.constant = 4
                overviewTitleTextHeightConstraint.priority = 250
                
//                overviewCell.hidden = false
                overviewTextBottomConstraint.constant = 20
                overviewTextHeightConstraint.priority = 250
            }
            
            //scrollContrainerView.invalidateIntrinsicContentSize()
            resizeScroll()
        } else {
            println("company is nil")
            // TODO unset everything?
        }
        
    }
    
    func resizeScroll() {
        view.layoutIfNeeded()
        
        //-- Brute Force It ~ 8x slower to calculate then getting the last time
        var contentRect = CGRectZero
        for view in scrollContrainerView.subviews {
            contentRect = CGRectUnion(contentRect, view.frame)
        }
        scrollContainerViewHeight.constant = contentRect.height + 20
        
        //-- Get last item ~ Fastest Method?
//        let localPoint: CGPoint = noOfEmployees.bounds.origin
//        let basePoint: CGPoint = noOfEmployees.convertPoint(localPoint, fromCoordinateSpace: scrollView)
//        scrollContainerViewHeight.constant = basePoint.y + noOfEmployees.bounds.height + 20
    }
    
    @IBAction func goBack(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
