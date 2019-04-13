//
//  FolderCollectionTableViewCell.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/9/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import UIKit

class FolderCollectionTableViewCell: UITableViewCell, DisplayableCell {
    
    static var identifier: String = "FolderCollectionTableCell"
    static var nibName: String = "FolderCollectionTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
