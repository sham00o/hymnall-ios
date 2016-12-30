//
//  Properties.swift
//  HymnAll
//
//  Created by Liu, Samuel Andreson V on 8/11/16.
//  Copyright © 2016 Upstream. All rights reserved.
//

import Foundation
import UIKit

class Properties {
    static let sharedInstance = Properties()
    
    private init() {}
    
    let mainColor = UIColor.init(red: 0.0, green: 247.0/255.0, blue: 44.0/255.0, alpha: 1.0)
    let inactiveColor = UIColor.lightGrayColor()
}