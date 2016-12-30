//
//  ChordsViewController.swift
//  HymnAll
//
//  Created by Liu, Samuel Andreson V on 8/13/16.
//  Copyright © 2016 Upstream. All rights reserved.
//

import UIKit

class ChordsViewController: UIViewController {
    
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
    
    var collectionsAreShowing = false
    
    private var chorus: [[[String]]]!
    private var stanzas: [[[String]]]!
    
    func setLyrics(lyrics: NSDictionary) {
        chorus = lyrics["chorus"] as? [[[String]]]
        stanzas = lyrics["stanza"] as? [[[String]]]
        
        if stanzaTable != nil {
            stanzaTable.reloadData()
        }
    }
    
    @IBOutlet weak var stanzaTable: UITableView!
    @IBOutlet weak var noteCollection: UICollectionView!
    @IBOutlet weak var chordCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chordCollection.delegate = self
        chordCollection.dataSource = self
        noteCollection.dataSource = self
        noteCollection.delegate = self
        stanzaTable.dataSource = self
        stanzaTable.rowHeight = UITableViewAutomaticDimension
        stanzaTable.estimatedRowHeight = 300

        hideCollections()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
//        Disabled until next release
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(showCollections(_:)), name: "wordTapped", object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func showCollections(notification: NSNotification) {
        if !collectionsAreShowing {
            collectionsAreShowing = true
            UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .CurveEaseIn, animations: {
                self.chordCollection.transform = CGAffineTransformIdentity
                self.noteCollection.transform = CGAffineTransformIdentity
                }, completion: nil)
        }
    }
    
    func hideCollections() {
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .CurveEaseIn, animations: {
            let width = self.chordCollection.frame.width
            self.chordCollection.transform = CGAffineTransformMakeTranslation(width, 0.0)
            self.noteCollection.transform = CGAffineTransformMakeTranslation(-width, 0.0)
            }, completion: nil)
        collectionsAreShowing = false
    }
    
}

extension ChordsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    // tell the collection view how many cells to make
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    // make a cell for each cell index path
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        collectionView.registerNib(UINib(nibName: "ChordCollectionCell", bundle: nil), forCellWithReuseIdentifier: "chord")
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("chord", forIndexPath: indexPath) as! ChordCollectionCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.label.text = self.items[indexPath.item]
        cell.layer.cornerRadius = 0.35 * cell.bounds.size.width

        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("chord", forIndexPath: indexPath) as! ChordCollectionCell
        cell.backgroundColor = UIColor.grayColor()
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        return CGSizeMake(30.0, 30.0)
    }
}

extension ChordsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if chorus == nil {
            return "stanzas"
        }
        return section == 0 ? "chorus" : "stanzas"
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if chorus != nil {
            return 2
        }
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if chorus == nil {
            return stanzas.count
        }
        return section == 0 ? chorus.count : stanzas.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerNib(UINib(nibName: "StanzaCell", bundle: nil), forCellReuseIdentifier: "stanza")
        let cell = tableView.dequeueReusableCellWithIdentifier("stanza", forIndexPath: indexPath) as! StanzaCell
        
        if chorus == nil {
            cell.loadCell(stanzas[indexPath.row])
        } else if indexPath.section == 0 {
            cell.loadCell(chorus[indexPath.row])
        } else {
            cell.loadCell(stanzas[indexPath.row])
        }
        
        return cell
    }
}
