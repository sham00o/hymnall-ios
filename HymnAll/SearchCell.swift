//
//  SearchCell.swift
//  HymnAll
//
//  Created by Liu, Samuel Andreson V on 8/8/16.
//  Copyright © 2016 Upstream. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadCell(data: String) {
        title.text = data
    }
    
}
