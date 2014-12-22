//
//  ListController.swift
//  Top Companies
//
//  Created by Bernard Kohantob on 12/22/14.
//  Copyright (c) 2014 minidev. All rights reserved.
//

import UIKit

class ListController : UIViewController {
    var categoryId : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        println("Loaded! with category \(categoryId)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}