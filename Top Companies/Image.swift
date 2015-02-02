//
//  Image.swift
//  Top Companies
//
//  Created by Bernard Kohantob on 2/1/15.
//  Copyright (c) 2015 minidev. All rights reserved.
//

import Foundation
import UIKit

class TPImage {
    let images = [
        "106387740",
        "118368146",
        "137875651",
        "146822494",
        "152503797",
        "164149948",
        "177133164",
        "177273726",
        "178639802",
        "462884189",
        "464198883",
        "464222553",
        "464222587",
        "464245129",
        "465574415",
        "467400545",
        "467499073",
        "476107639",
        "476212207",
        "487441425",
        "491939507",
        "76945379",
        "76945380",
        "76945404",
        "94192864",
        "94681342",
    ]
    
    func getRandomString() -> String {
        let randomIndex = random() % images.count
        return images[randomIndex]
    }
    
    func getRandomImage() -> UIImage? {
        return UIImage(named: getRandomString())
    }
}