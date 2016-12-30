//
//  String.swift
//  HymnAll
//
//  Created by Liu, Samuel Andreson V on 8/13/16.
//  Copyright © 2016 Upstream. All rights reserved.
//

import Foundation

extension String {
    
    func split(regex pattern: String) -> [String] {
        
        guard let re = try? NSRegularExpression(pattern: pattern, options: [])
            else { return [] }
        
        let nsString = self as NSString // needed for range compatibility
        let stop = "<SomeStringThatYouDoNotExpectToOccurInSelf>"
        let modifiedString = re.stringByReplacingMatchesInString(
            self,
            options: [],
            range: NSRange(location: 0, length: nsString.length),
            withTemplate: stop)
        return modifiedString.componentsSeparatedByString(stop)
    }
}