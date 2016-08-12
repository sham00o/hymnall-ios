//
//  ViewController.swift
//  HymnAll
//
//  Created by Liu, Samuel Andreson V on 8/8/16.
//  Copyright © 2016 Upstream. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class HomeViewController: UIViewController {
    
    final let SHOW_ANIMATION_DURATION = 0.5
    final let HIDE_ANIMATION_DURATION = 0.4
    
    private var results = [String]()
    
    weak var hymnView: HymnView!

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTable.delegate = self
        searchTable.dataSource = self

        Alamofire.request(.GET, "https://hymnall.herokuapp.com/sushi.json")
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
                
                let json = JSON(data: response.data!)
                self.results = json["sushi"].arrayObject as![String]
                self.searchTable.reloadData()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        hymnView = NSBundle.mainBundle().loadNibNamed("HymnView", owner: self, options: nil)[0] as! HymnView
        hymnView.delegate = self
        // Decrease the sliding view slightly
        var hymnViewSize: CGSize = CGSizeMake(0, 0)
        hymnViewSize.width = self.view.frame.size.width - 40
        hymnViewSize.height = self.view.frame.size.height - 40
        hymnView.frame =  CGRect(x: self.view.center.x, y: self.view.center.y, width: hymnViewSize.width, height: hymnViewSize.height)
        
        // Set the centre of the sliding view to be the same as the main view
        hymnView.center = self.view.center
        
        // Move the sliding view off the screen at the right edge.
        hymnView.frame.origin.y = self.view.frame.size.height + hymnView.frame.size.height
        
        // Makes a delegate connection between the ViewController and the instance of SlidingView
//        hymnView.delegate = self
        
        // Add the instance of SlidingView (hymnView) to the main view.
        self.view.addSubview(hymnView)
    }
    
    func showHymnView() {
        UIView.animateWithDuration(SHOW_ANIMATION_DURATION, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.hymnView.center.y = self.view.center.y
            }, completion: {
                finished in
        })
    }
    
}

extension HomeViewController: HymnViewDelegate {
    
    func dismissView() {
        UIView.animateWithDuration(HIDE_ANIMATION_DURATION, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.hymnView.center.y = self.view.frame.size.height + self.hymnView.frame.size.height
            }, completion: {
                finished in
        })
    }
    
    func positionView() {
        showHymnView()
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // temp loading
        hymnView.loadView(results[indexPath.row])
        showHymnView()
    }
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerNib(UINib(nibName: "SearchCell", bundle: nil), forCellReuseIdentifier: "search")
        let cell = tableView.dequeueReusableCellWithIdentifier("search", forIndexPath: indexPath) as! SearchCell
        
        cell.loadCell(results[indexPath.row])
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
}

