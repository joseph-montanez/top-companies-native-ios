//
//  TestController.swift
//  Top Companies
//
//  Created by Bernard Kohantob on 4/3/15.
//  Copyright (c) 2015 minidev. All rights reserved.
//

import Foundation
import UIKit

class TestController : UIViewController {
    @IBOutlet weak var l1: UILabel!
    @IBOutlet weak var l2: UILabel!
    @IBOutlet weak var l3: UILabel!
    @IBOutlet weak var longView: UIView!
    @IBOutlet weak var l1ph: NSLayoutConstraint!
    @IBOutlet weak var l1pt: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        l1.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque dolor elit, condimentum eget tincidunt facilisis, accumsan in mi. Aliquam in aliquam mauris. Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vulputate nunc purus, vitae feugiat lacus congue vitae. Duis lobortis ligula varius tellus cursus blandit. Sed viverra metus non lacus dignissim congue sit amet eget justo. Vestibulum diam nisi, tristique non odio a, ultrices sagittis tortor. Fusce rutrum sem sit amet vestibulum efficitur. Donec a erat tortor."
    }
    
    @IBAction func hideL1(sender: AnyObject) {
        l1.text = ""
        l1ph.constant = 0
        l1ph.priority = 750
        l1pt.constant = 0
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.updateViewConstraints()
    }
}
