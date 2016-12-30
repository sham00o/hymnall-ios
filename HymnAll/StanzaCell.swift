//
//  StanzaCell.swift
//  HymnAll
//
//  Created by Liu, Samuel Andreson V on 8/13/16.
//  Copyright © 2016 Upstream. All rights reserved.
//

import UIKit

class StanzaCell: UITableViewCell {
    
    @IBOutlet weak var wordView: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(StanzaCell.textViewTapped(_:)))
        gestureRecognizer.numberOfTapsRequired = 1;
        gestureRecognizer.numberOfTouchesRequired = 1;
        wordView.addGestureRecognizer(gestureRecognizer);
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func loadCell(stanza: [[String]]) {
        var string = ""
        for i in 0...stanza.count-1 {
            let line = stanza[i]
            for j in 0...line.count-1 {
                let word = line[j]
                string += j < line.count-1 ? word + " " : word
            }
            string += i < stanza.count-1 ? "\n" : ""
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 20.0
        
        let attrString = NSMutableAttributedString(string: string)
        attrString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attrString.length))
        
        wordView.attributedText = attrString
    }
    
    func textViewTapped(sender: UITapGestureRecognizer) {
        let word = UITextView.getWordAtPosition(sender.locationInView(wordView), textView: wordView);
        print(word)
        NSNotificationCenter.defaultCenter().postNotificationName("wordTapped", object: nil)
    }
}
