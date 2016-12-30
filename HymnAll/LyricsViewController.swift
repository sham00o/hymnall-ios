//
//  LyricsViewController.swift
//  HymnAll
//
//  Created by Liu, Samuel Andreson V on 8/11/16.
//  Copyright © 2016 Upstream. All rights reserved.
//

import UIKit


class LyricsViewController: UIViewController {
    
    let CHORUS_PLACEHOLDER_TEXT = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
    
    let STANZA_PLACEHOLDER_TEXT = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
    
    var loaded = false
    var chorusState = true
    var lyricsDictionary: NSDictionary!

    @IBOutlet weak var chorusButton: UIButton!
    @IBOutlet weak var chorusView: UITextView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        chorusView.delegate = self
        textView.delegate = self
        chorusView.text = CHORUS_PLACEHOLDER_TEXT
        textView.text = STANZA_PLACEHOLDER_TEXT
        chorusView.textColor = UIColor.lightGrayColor()
        textView.textColor = UIColor.lightGrayColor()
        chorusButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        
        let toolbar = UIToolbar()
        let done = UIBarButtonItem(title: "Done", style: .Done, target: self, action: #selector(finishTyping))
        toolbar.items = [done]
        toolbar.sizeToFit()
        chorusView.inputAccessoryView = toolbar
        textView.inputAccessoryView = toolbar
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !loaded {
            loaded = true
            toggleChorus(chorusButton)
        }
    }
    
    func finishTyping() {
        view.endEditing(true)
    }
    
    func decompose(text: String) -> [[[String]]] {
        let stanzas = text.split(regex: "\\s{2,}")
        var stanzasParsed = [[[String]]]()
        for stanza in stanzas {
            var linesParsed = [[String]]()
            let lines = stanza.componentsSeparatedByString("\n")
            for line in lines {
                let words = line.componentsSeparatedByString(" ")
                linesParsed.append(words)
            }
            stanzasParsed.append(linesParsed)
        }
        return stanzasParsed
    }
    
    func parseLyrics() -> NSDictionary {
        lyricsDictionary = NSDictionary()
        lyricsDictionary = chorusState == true ?
            ["chorus":decompose(chorusView.text), "stanza":decompose(textView.text)] :
            ["stanza":decompose(textView.text)]
        return lyricsDictionary
    }
    
    @IBAction func toggleChorus(sender: AnyObject) {
        if chorusState == true {
            chorusButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
            UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: {
                self.textView.transform = CGAffineTransformMakeTranslation(0.0, -(self.chorusView.frame.height+16))
                self.view.layoutIfNeeded()
                }, completion: nil)
            chorusView.hidden = true
            chorusState = false
        } else {
            chorusButton.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
            chorusView.hidden = false
            UIView.animateWithDuration(0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: .CurveEaseInOut, animations: {
                self.textView.transform = CGAffineTransformIdentity
                self.view.layoutIfNeeded()
                }, completion: nil)
            chorusState = true
        }
    }
    
}

extension LyricsViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(textView: UITextView) {
        if textView.text == STANZA_PLACEHOLDER_TEXT || textView.text == CHORUS_PLACEHOLDER_TEXT {
            textView.text = ""
            textView.textColor = UIColor.darkGrayColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text == "" {
            textView.text = textView == chorusView ? CHORUS_PLACEHOLDER_TEXT : STANZA_PLACEHOLDER_TEXT
            textView.textColor = UIColor.lightGrayColor()
        }
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
}
