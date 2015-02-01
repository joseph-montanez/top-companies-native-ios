//
//  KeywordTableViewCell.swift
//  Top Companies
//
//  Created by Joseph Montanez on 1/31/15.
//  Copyright (c) 2015 Comentum Corp. All rights reserved.
//

import Foundation
import UIKit

class KeywordTableViewCell: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    
    func loadItem(#title: String) {
        titleLabel.text = title
    }
}
