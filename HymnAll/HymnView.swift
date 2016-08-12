//
//  HymnView.swift
//  HymnAll
//
//  Created by Liu, Samuel Andreson V on 8/9/16.
//  Copyright © 2016 Upstream. All rights reserved.
//

import UIKit

protocol HymnViewDelegate {
    func dismissView()
    func positionView()
}

class HymnView: UIView {
    
    var dragOffset: CGFloat?
    var delegate: HymnViewDelegate?
    var handleTouches = true
    var shouldReposition = false
    var lastLocation:CGPoint = CGPointMake(0, 0)

    @IBOutlet weak var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        dragOffset = self.frame.height/3
        let panRecognizer = UIPanGestureRecognizer(target:self, action:#selector(HymnView.detectPan(_:)))
        self.gestureRecognizers = [panRecognizer]
    }
    
    func loadView(title: String) {
        titleLabel.text = title
        handleTouches = true
    }
    
    func detectPan(sender: UIPanGestureRecognizer) {
        if handleTouches {
            let translation = sender.translationInView(self.superview)
            let newY = (lastLocation.y + translation.y) < self.superview?.center.y ? self.superview?.center.y : lastLocation.y + translation.y
            self.center = CGPointMake(lastLocation.x, newY!)
            if self.center.y > ((self.superview?.center.y)! + dragOffset!) {
                //dismiss
                handleTouches = false
                delegate?.dismissView()
            } else {
                //bounce back
                if sender.state == .Ended {
                    delegate?.positionView()
                }
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        // Remember original location
        lastLocation = self.center
    }
    
}
