//
//  AddSongViewController.swift
//  HymnAll
//
//  Created by Liu, Samuel Andreson V on 8/11/16.
//  Copyright © 2016 Upstream. All rights reserved.
//

import UIKit

class AddSongViewController: UIViewController {
    
    var effectView: UIVisualEffectView!
    var pageViewController: AddPageViewController!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var pageContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(wordTapped(_:)), name: "wordTapped", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(collectionScrolled(_:)), name: "collectionScrolled", object: nil)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "wordTapped", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "collectionScrolled", object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        backButton.layer.cornerRadius = 0.5 * backButton.bounds.size.width
        forwardButton.layer.cornerRadius = 0.5 * forwardButton.bounds.size.width
    }
    
    func checkTextView() {
        if textView.text != "" {
            forwardButton.backgroundColor = Properties.sharedInstance.mainColor
        } else {
            forwardButton.backgroundColor = Properties.sharedInstance.inactiveColor
        }
    }
    
    func collectionScrolled(notification: NSNotification) {
        
    }
    
    func wordTapped(notification: NSNotification) {
//        let effect = UIBlurEffect(style: .ExtraLight)
//        effectView = UIVisualEffectView(effect: effect)
//        effectView.frame = self.view.frame
//        effectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
//        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(removeBlur(_:)))
//        effectView.addGestureRecognizer(tap)
//        
//        self.view.addSubview(effectView)
    }
    
    func removeBlur(sender: UITapGestureRecognizer) {
//        effectView.removeFromSuperview()
    }
    
    @IBAction func dismissTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func backTapped(sender: AnyObject) {
        pageViewController.previousPage()
    }
    
    @IBAction func nextTapped(sender: AnyObject) {
        pageViewController.nextPage()
    }
    
    func submitTapped(sender: AnyObject) {
        print("HI")
        dismissTapped(self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "embedded" {
            pageViewController = segue.destinationViewController as! AddPageViewController
            pageViewController.addDelegate = self
            
        }
    }
}

extension AddSongViewController: AddPageViewDelegate {
    
    func isAtEndOfPages(flag: Bool) {
        if flag {
            forwardButton.setTitle("✓", forState: .Normal)
            forwardButton.backgroundColor = Properties.sharedInstance.mainColor
            forwardButton.removeTarget(self, action: #selector(nextTapped(_:)), forControlEvents: .TouchUpInside)
            forwardButton.addTarget(self, action: #selector(submitTapped(_:)), forControlEvents: .TouchUpInside)
        } else {
            forwardButton.setTitle("›", forState: .Normal)
            forwardButton.backgroundColor = UIColor.lightGrayColor()
            forwardButton.removeTarget(self, action: #selector(submitTapped(_:)), forControlEvents: .TouchUpInside)
            forwardButton.addTarget(self, action: #selector(nextTapped(_:)), forControlEvents: .TouchUpInside)
        }
    }
}