//
//  KeywordTableViewCell.swift
//  Top Companies
//
//  Created by Bernard Kohantob on 1/31/15.
//  Copyright (c) 2015 minidev. All rights reserved.
//

import Foundation
import UIKit

class KeywordTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    
    func loadItem(#title: String) {
        titleLabel.text = title
    }
}
