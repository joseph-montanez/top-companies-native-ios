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
    
    // Description
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var descriptionTextHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionTextTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionTextBottomConstraint: NSLayoutConstraint!
    
    // Business
    @IBOutlet weak var businessText: UILabel!
    @IBOutlet weak var businessTextTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var businessTextHeightConstraint: NSLayoutConstraint!
    
    // Year
    @IBOutlet weak var yearEstText: UILabel!
    @IBOutlet weak var yearEst: UILabel!
    @IBOutlet weak var yearEstTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var yearEstTextHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var yearEstHeightConstraint: NSLayoutConstraint!
    
    // Annual Revenue
    @IBOutlet weak var annualRevText: UILabel!
    @IBOutlet weak var annualRev: UILabel!
    @IBOutlet weak var annualRevTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var annualRevTextHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var annualRevHeightConstraint: NSLayoutConstraint!
    
    // Number of Employees
    @IBOutlet weak var employeeNoText: UILabel!
    @IBOutlet weak var employeeNo: UILabel!
    @IBOutlet weak var employeeNoTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var employeeNoTextHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var employeeNoHeightConstraint: NSLayoutConstraint!
    
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
                
            companyName.text = company.name
            address.text = company.address
            cityStateZip.text = company.city
            website.text = company.website
            phone.text = company.phone
            overviewText.text = company.description
            descriptionText.text = company.descriptionMeta
            yearEst.text = String(company.founded)
            
            var formatter = NSNumberFormatter()
            formatter.numberStyle = .CurrencyStyle
            annualRev.text = formatter.stringFromNumber(company.revenue)
            
            employeeNo.text = String(company.employeeNo)
            
            
            if countElements(company.description) == 0 {
                overviewTitleText.text = ""
                overviewTitleTextTopConstraint.constant = 0
                overviewTitleTextBetweenConstraint.constant = 0
                overviewTitleTextHeightConstraint.constant = 0
                overviewTitleTextHeightConstraint.priority = 750
                
                
                overviewTextBottomConstraint.constant = 0
                overviewTextHeightConstraint.constant = 0
                overviewTextHeightConstraint.priority = 750
            } else {
                overviewTitleText.text = "Overview"
                overviewTitleTextTopConstraint.constant = 15
                overviewTitleTextBetweenConstraint.constant = 4
                overviewTitleTextHeightConstraint.priority = 250
                
                overviewTextBottomConstraint.constant = 20
                overviewTextHeightConstraint.priority = 250
            }
            
            if countElements(company.descriptionMeta) == 0 {
                descriptionTextTopConstraint.constant = 0
                descriptionTextBottomConstraint.constant = 0
                descriptionTextHeightConstraint.constant = 0
                descriptionTextHeightConstraint.priority = 750
            } else {
                descriptionTextTopConstraint.constant = 15
                descriptionTextBottomConstraint.constant = 20
                descriptionTextHeightConstraint.priority = 250
            }
            
            if company.employeeNo == 0 && company.revenue == 0 && company.founded == 0 {
                businessText.text = ""
                businessTextTopConstraint.constant = 0
                businessTextHeightConstraint.constant = 0
                businessTextHeightConstraint.priority = 750
                
            } else {
                businessText.text = "Business Information"
                businessTextTopConstraint.constant = 15
                businessTextHeightConstraint.priority = 250
            }
            
            if company.founded == 0 {
                yearEst.text = ""
                yearEstText.text = ""
                yearEstTextHeightConstraint.constant = 0
                yearEstTextHeightConstraint.priority = 750
                yearEstTopConstraint.constant = 0
            } else {
                yearEstText.text = "Year Established:"
                yearEstTextHeightConstraint.priority = 250
                yearEstTopConstraint.constant = 8
            }
            
            if company.revenue == 0 {
                annualRev.text = ""
                annualRevText.text = ""
                annualRevTextHeightConstraint.constant = 0
                annualRevTextHeightConstraint.priority = 750
                annualRevTopConstraint.constant = 0
            } else {
                annualRevText.text = "Annual Revenue:"
                annualRevTextHeightConstraint.priority = 250
                annualRevTopConstraint.constant = 8
            }
            
            if company.employeeNo == 0 {
                employeeNo.text = ""
                employeeNoText.text = ""
                employeeNoTextHeightConstraint.constant = 0
                employeeNoTextHeightConstraint.priority = 750
                employeeNoTopConstraint.constant = 0
            } else {
                employeeNoText.text = "No. Employees:"
                employeeNoTextHeightConstraint.priority = 250
                employeeNoTopConstraint.constant = 8
            }
            
            
            resizeScroll()
        } else {
            println("company is nil")
            // TODO unset everything?
        }
        
    }
    
    func resizeScroll() {
        view.layoutIfNeeded()
        
        var contentRect = CGRectZero
        for view in scrollContrainerView.subviews {
            contentRect = CGRectUnion(contentRect, view.frame)
        }
        scrollContainerViewHeight.constant = contentRect.height + 20
    }
    
    @IBAction func goBack(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
