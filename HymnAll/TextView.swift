//
//  TextView.swift
//  HymnAll
//
//  Created by Liu, Samuel Andreson V on 8/14/16.
//  Copyright © 2016 Upstream. All rights reserved.
//

import UIKit

extension UITextView {
    class func getWordAtPosition(position: CGPoint, textView: UITextView) -> String? {
        //Remove scrolloffset
        let correctedPoint = CGPointMake(position.x, textView.contentOffset.y + position.y);
        //Get location in text from uitextposition at a certian point
        if let tapPosition = textView.closestPositionToPoint(correctedPoint) {
            //Get word at the position, will return nil if its empty.
            if let wordRange = textView.tokenizer.rangeEnclosingPosition(tapPosition, withGranularity: UITextGranularity.Word, inDirection: UITextLayoutDirection.Right.rawValue) {
                return textView.textInRange(wordRange);
            }
            return nil
        }
        return nil
    }
}