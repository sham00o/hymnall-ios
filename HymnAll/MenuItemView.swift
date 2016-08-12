//
//  MenuItemView.swift
//  HymnAll
//
//  Created by Liu, Samuel Andreson V on 8/10/16.
//  Copyright © 2016 Upstream. All rights reserved.
//

import UIKit

@IBDesignable class MenuItemView: UIView {
    
    var view: UIView!

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    
    @IBInspectable var itemLabel: String? {
        get {
            return label.text
        }
        set(message) {
            label.text = message
        }
    }
    
    @IBInspectable var item: String? {
        get {
            return button.titleForState(UIControlState.Normal)
        }
        set(text) {
            button.setTitle(text, forState: UIControlState.Normal)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        // setup the view from .xib
        view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        addSubview(view)
        button.layer.cornerRadius = 0.35 * button.bounds.size.width
    }
    
    func loadViewFromNib() -> UIView {
        // grabs the appropriate bundle
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: "MenuItemView", bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }

}
