//
//  Company.swift
//  Top Companies
//
//  Created by Joseph Montanez on 1/5/15.
//  Copyright (c) 2015 Comentum Corp. All rights reserved.
//

import Foundation

class TPCompany {
    var id : Int = 0
    var name : String = ""
    var address : String = ""
    var phone : String = ""
    var city : String = ""
    var state : String = ""
    var website : String = ""
    var zip : String = ""
    var description : String = ""
    var descriptionInternal : String = ""
    var descriptionMeta : String = ""
    var employeeNo : Int = 0
    var revenue : Int = 0
    var founded : Int = 0
    
    func getCityStateZip() {
        if (countElements(city) > 0) {
        }
    }
    
    func fromJson(json: NSDictionary) {
        id = json["companies_id"] as Int
        name = json["companies_name"] as String
        address = json["companies_address"] as String
        phone = json["companies_phone"] as String
        city = json["companies_city"] as String
        state = json["companies_state"] as String
        website = json["companies_website"] as String
        zip = json["companies_zip"] as String
        if (json.objectForKey("companies_description") != nil) {
            description = json["companies_description"] as String
        }
        if (json.objectForKey("companies_description_internal") != nil) {
            descriptionInternal = json["companies_description_internal"] as String
        }
        if (json.objectForKey("descriptionMeta") != nil) {
            descriptionInternal = json["descriptionMeta"] as String
        }
        if (json.objectForKey("companies_employee_count") != nil) {
            employeeNo = json["companies_employee_count"] as Int
        }
        if (json.objectForKey("companies_revenue") != nil) {
            revenue = json["companies_revenue"] as Int
        }
        if (json.objectForKey("companies_founded") != nil) {
            founded = json["companies_founded"] as Int
        }
    }
}