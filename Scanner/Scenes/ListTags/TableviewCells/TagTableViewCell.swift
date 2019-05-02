//
//  TagTableViewCell.swift
//  Scanner
//
//  Created by Zaizen Kaegyoshi on 4/17/19.
//  Copyright © 2019 zzzz. All rights reserved.
//

import UIKit

class TagTableViewCell: UITableViewCell, DisplayableCell {
    
    static var identifier: String = "TagCell"
    static var nibName: String = "TagTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var checkmark: UIImageView!
    
    @IBOutlet weak var depthDistanceContraint: NSLayoutConstraint!
    
    func setCell(name: String, color: UIColor, depth: Int, selected: Bool) {
        self.nameLabel.text = name
        self.colorView.backgroundColor = color
        self.checkmark.isHidden = !selected
        
        self.depthDistanceContraint.constant = CGFloat(16 + 26 * depth)
        self.layoutIfNeeded()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
