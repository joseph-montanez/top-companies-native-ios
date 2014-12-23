//
//  SearchItem.swift
//  Top Companies
//
//  Created by Joseph Montanez on 12/23/14.
//  Copyright (c) 2014 Comentum Corp. All rights reserved.
//

import Foundation


enum TPSearchItemType {
    case Category
    case Company
}

class TPSearchItem {
    var name = "";
    var id = "";
    var type = TPSearchItemType.Category;
    
    init(name: String) {
        self.name = name
    }
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
    init(name: String, id: String, type: TPSearchItemType) {
        self.name = name
        self.id = id
        self.type = type
    }
    init?(label: String, value: String) {
        self.name = label
        let matchedValue = parseValue(value)
        if (!matchedValue) {
            return nil
        }
    }
    
    func parseValue(value: String) -> Bool {
        let parts = value.componentsSeparatedByString("_")
        if (parts.count == 2) {
            let tparts = (parts[0], parts[1])
            switch tparts {
            case let ("company", id):
                self.id = id
                self.type = .Company
                return true
            case let ("keyword", id):
                self.id = id
                self.type = .Category
                return true
            default:
                // Do nothing
                println("No matches found")
                return false
            }
        } else {
            return false
        }
    }
}
